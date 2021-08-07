// PLANE AND HELICOPTER THAT FLY RANDOMLY AROUND THE MAP

if (!isServer) exitWith {};

private _aircraft = [
	ambient_plane_1, 
	ambient_helicopter_1
];

if (MALO_CFG_ambient_aircraft) then {
	{
		{
			
			[[_x], false] call MALO_fnc_hideObjects;

			/*if (!simulationEnabled _x) then {
				_x enableSimulationGlobal true;
				_x enableDynamicSimulation false;
			};

			if (isObjectHidden _x) then {
				_x hideObjectGlobal false;
			};*/

			_x setFuel 1;

		} forEach [driver _x, _x];
	} forEach _aircraft;
} else {
	{
		{
			[[_x], true] call MALO_fnc_hideObjects;
			/*_x enableSimulationGlobal false;
			_x hideObjectGlobal true;*/
		} forEach [driver _x, _x];
	} forEach _aircraft;
};