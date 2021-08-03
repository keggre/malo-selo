// PLANE AND HELICOPTER THAT FLY RANDOMLY AROUND THE MAP

if (!isServer) exitWith {};

private _aircraft = [
	ambient_plane_1, 
	ambient_helicopter_1
];

if (MALO_CFG_ambient_aircraft == true) then {
	{
		{
			_x enableSimulationGlobal true;
			_x hideObjectGlobal false;
			_x setFuel 1;
		} forEach [_x, driver _x];
	} forEach _aircraft;
} else {
	{
		{
			_x enableSimulationGlobal false;
			_x hideObjectGlobal true;
		} forEach [_x, driver _x];
	} forEach _aircraft;
};