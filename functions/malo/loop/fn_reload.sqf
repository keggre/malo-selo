// GUNS WITH INFINITE AMMO

if (!isServer) exitWith {};

/* ["MALO_infinite_ammo", this] call MALO_fnc_append; */

private _vehicles = missionNamespace getVariable ["MALO_infinite_ammo", []];

{
	_x setVehicleAmmo 1;
} forEach _vehicles;