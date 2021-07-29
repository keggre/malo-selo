// CREATES EVENT HANDLERS THAT IMPROVE AI COMBAT REALISM

if (!isServer) exitWith {};
if (!MALO_CFG_advanced_ai) exitWith {};

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

	private _positions = [[0,0,0]];
	{
		{_positions append [_x];} forEach (_x buildingPos -1);
	} forEach _objects;

	private _position = selectRandom _positions;

	_unit doMove _position;

	waitUntil {(unitReady _unit) || ((_unit distance (_unit call MALO_fnc_getClosestPlayer)) > 100)};

	sleep 5;

	_unit setVariable ["willGetInside", false, true];
	
};


// LOOPING THROUGH NEARBY UNITS

{

	if (side _x in _sides && !isPlayer _x) then {
		
		if !(_x getVariable ["willGetInside", false]) then {
			
			_x setVariable ["willGetInside", true, true];

			_x addEventHandler ["FiredNear", {

				private _unit = _this select 0;

				group _unit setBehaviour "COMBAT";
				
				_unit spawn MALO_fnc_combat_getInside;

				_unit removeEventHandler ["FiredNear", _thisEventHandler];

			}];

		};

		if (_x distance (_x findNearestEnemy _x) < 50) then {

			_x enableAi "ALL";

		};

		if (_x call BIS_fnc_enemyDetected) then {
			
			if ((combatMode (group _x)) == "SAFE") then {

				(group _x) setCombatMode "AWARE";

			};

		} else {

			(group _x) setCombatMode "SAFE";

		};

	};

	if (typeOf _x == "LOP_UN_Infantry_Rifleman") then {

		private _targeted = _x getVariable ["targeted", false];
		private _armed = _x call MALO_fnc_isArmed;

		if (_targeted && _armed) then {

			private _group = createGroup west;
			(units (group _x)) joinSilent _group;

		};

	};

} forEach MALO_combat_units;