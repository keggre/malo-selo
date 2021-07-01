_leader = cap_3;
_pos = getMarkerPos 'cap_marker_3'; 

{ 
if ( _x != _leader ) then { 
 _relDis = _x distance _leader; 
 _relDir = [_leader, _x] call BIS_fnc_relativeDirTo; 
 _x setPos ([_pos, _relDis, _relDir] call BIS_fnc_relPos); 
};  
}forEach units group _leader; 

_leader setPos _pos; 

{_x enableAi 'ALL'; _x enableSimulation true; _x enableDynamicSimulation true;} forEach units group _leader;