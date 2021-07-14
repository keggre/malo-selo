// CREATES EVENT HANDLERS THAT IMPROVE AI COMBAT REALISM

if (!isServer) exitWith {};

private _sides = [east, west];
private _radius = MALO_simulation_distance;


MALO_combat_units = [];
{MALO_combat_units append (nearestObjects [_x, ["MAN"], _radius]);} forEach playableUnits;

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

	waitUntil {unitReady _unit};

	_unit setVariable ["willGetInside", false, true];
	
};

{

	if (side _x in _sides && !isPlayer _x) then {
		
		if !(_x getVariable ["willGetInside", false]) then {
			
			_x setVariable ["willGetInside", true, true];

			_x addEventHandler ["FiredNear", {

				private _unit = _this select 0;

				group _unit setBehaviour "COMBAT";
				_unit spawn MALO_fnc_combat_getInside;

			}];

		};

	};

} forEach MALO_combat_units;