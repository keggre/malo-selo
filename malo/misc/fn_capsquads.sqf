// TELEPORTS CAPSQUADS TO THEIR DESTINATIONS

if (false) exitWith {};

params ["_leader", "_pos"];

if (_leader getVariable ["teleported", false]) exitWith {};
_leader setVariable ["teleported", true, true];

// waitUntil {(_pos distance (_pos call MALO_fnc_getClosestPlayer)) > 100};

{ 

	if ( _x != _leader ) then { 

		_relDis = _x distance _leader; 
		_relDir = [_leader, _x] call BIS_fnc_relativeDirTo; 
		_x setPos ([_pos, _relDis, _relDir] call BIS_fnc_relPos); 
		
	};  

} forEach units group _leader; 

_leader setPos _pos; 

{

	_x enableAi 'ALL'; 
	_x enableDynamicSimulation true;

} forEach units group _leader;

group _leader enableDynamicSimulation true;