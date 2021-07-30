// IMPROVES COMBAT REALISM

if (!isServer) exitWith {};
if (!MALO_CFG_advanced_ai) exitWith {};

MALO_sniper_types = ["I_Bosnia_and_Herzegovina_Sniper_01"];

private _sides = [east, west];
private _radius = MALO_simulation_distance;


MALO_combat_units = [];
{MALO_combat_units append (nearestObjects [_x, ["MAN"], _radius]);} forEach playableUnits;


// MAKES UNITS GET IN BUILDINGS WHEN FIRED UPON

MALO_fnc_combat_getInside = {
	
	params ["_unit"];

	private _building_types = MALO_building_types;
	private _radius = 50;

	private _objects = nearestObjects [_unit, _building_types, _radius];

	private _positions = [(position _unit)];
	{
		{_positions append [_x];} forEach (_x buildingPos -1);
	} forEach _objects;

	private _position = selectRandom _positions;

	_unit doMove _position;

	waitUntil {(unitReady _unit) or (({alive _x} count (units player_squad)) < 1) or ((_unit distance (_unit call MALO_fnc_getClosestPlayer)) > 100)};

	sleep 5;

	_unit setVariable ["willGetInside", false, true];
	
};


// LOOPING THROUGH NEARBY UNITS

{
	
	if (side _x in _sides && !isPlayer _x) then {
		

		// CREATE GET IN BUILDING EVENT HANDLER

		if !(_x getVariable ["willGetInside", false]) then {
			
			_x setVariable ["willGetInside", true, true];

			_x addEventHandler ["FiredNear", {
				private _unit = _this select 0;
				if ((behaviour _x == "SAFE") && (unitPos _x == "UP")) then {
					_x setUnitPos "MIDDLE";
				};
				group _unit setBehaviour "COMBAT";
				_unit spawn MALO_fnc_combat_getInside;
				_unit removeEventHandler ["FiredNear", _thisEventHandler];
			}];

		};

		// CREATE MORALE EVENT HANDLER

		if !(_x getVariable ["killedMoraleEventHandlerCreated", false]) then {

			_x setVariable ["killedMoraleEventHandlerCreated", true, true];

			_x addEventHandler ["Killed", {
				private _unit = _this select 0;
				private _group = group _unit;
				_group setVariable ["morale", ((_group getVariable ["morale", 100]) - (100 / (count units _group))), true]
			}];

		};


		// ENABLE ALL AI IF ENEMY WITHIN TEN METERS

		if (_x distance (_x findNearestEnemy _x) < 10) then {
			_x enableAi "ALL";
		};


		// SURRENDER IF MORALE LOW ENOUGH

		if ((_x getVariable ["targeted", false]) && (((group _x) getVariable ["morale", 100]) < 20) && (side _x != east)) then {
			removeAllWeapons _x;
			private _group = createGroup civilian;
			[_x] joinSilent _group;
		};


		// FREEZE SAFE UNITS IF IN A GROUP OF TWO OR MORE

		if ((count units group _x > 1) && (vehicle _x == _x) && !(count waypoints group _x > 1)) then {
			if (_x call BIS_fnc_enemyDetected) then {
				_x enableAi "ALL";
			} else {
				_x disableAI "PATH";
			};
		};


		// BEHAVIOR

		private _unit = _x;
		private _group = group _unit;

		private _morale = _group getVariable ["morale", 100];

		if (_unit call BIS_fnc_enemyDetected) then {

			if ((behaviour _unit) == "SAFE") then {
				_group setBehaviour "AWARE";
			};

		} else {

			(group _unit) setBehaviour "SAFE";

		};

		if (behaviour _unit == "AWARE" && !(count waypoints _group > 1)) then {

			_group setBehaviour "COMBAT";

		};


		// COMBAT MODES AND SPEED MODES

		private _unit = _x;
		private _group = group _unit;

		private _sniper = (if (typeOf _unit in MALO_sniper_types) then {true} else {false});
		private _in_vehicle = vehicle _unit != _unit;
		private _enemy_spotted = _unit call BIS_fnc_enemyDetected;
		private _defensive = _group getVariable ["defensive", true];
		private _morale = _group getVariable ["morale", 100];

		if (_sniper || _in_vehicle) then {

			_group setSpeedMode "FULL";
			_group setCombatMode "RED";
			

		} else {

			if (!_enemy_spotted) then {

				_group setSpeedMode "NORMAL";

				if (count waypoints _group > 1) then {
					_group setCombatMode "GREEN";
				} else {
					_group setCombatMode "WHITE";
				};

			} else {
				
				if (!_defensive && _morale > 20) then {

					_group setSpeedMode "FULL";
					_group setCombatMode "RED";

				} else {

					_group setSpeedMode "FULL";
					
					private _distance = (_unit distance (_unit findNearestEnemy _unit));
					private _mid = 100;
					private _far = 300;
					private _range = "close";
					if (_distance > _mid) then {
						_range = "mid";
					} else {
						if (_distance > _far) then {
							_range = "far";
						};
					};

					switch (_range) do {
						
						case "close": {
							if (_morale < 20) then {
								_group setCombatMode "BLUE";
							} else {
								_group setCombatMode "RED";
							};
						};

						case "mid": {
							if (_morale < 40) then {
								_group setCombatMode "BLUE";
							} else {
								_group setCombatMode "WHITE";
							};
						};
						
						case "far": {
							if (_morale < 60) then {
								_group setCombatMode "BLUE";
							} else {
								_group setCombatMode "WHITE";
							};
						};
						
						default {};
					
					};
				
				};

			};

		};


		// FORMATIONS AND UNIT POSITIONS

		private _unit = _x;
		private _group = group _unit;

		private _behavior = behaviour _unit;
		private _unit_pos = unitPos _unit;

		switch (_behavior) do {

			case "SAFE": {

				_group setFormation "FILE";

				if (_unit_pos == "DOWN") then {
					_unit setUnitPos "MIDDLE";
				} else {
					_unit setUnitPos "AUTO";
				};

			};
			
			case "AWARE": {

				_group setFormation "FILE";

				if ((speed (vehicle _unit))  == 0) then {
					_unit setUnitPos "MIDDLE";
				} else {
					_unit setUnitPos "UP";
				};

			};

			case "COMBAT": {

				_group setFormation "FILE";
				_unit setUnitPos "AUTO";

			};

			default {};

		};

	};


	// MAKE UN UNITS HOSTILE WHEN A GUN IS POINTED AT THEM

	if (typeOf _x == "LOP_UN_Infantry_Rifleman") then {

		private _targeted = _x getVariable ["targeted", false];
		private _armed = _x call MALO_fnc_isArmed;

		if (_targeted && _armed) then {

			private _group = createGroup west;
			(units (group _x)) joinSilent _group;

		};

	};

} forEach MALO_combat_units;