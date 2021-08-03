// SCHEDULES DELETION OF OBJECTS RELATED TO THE UN CHECKPOINTS

if (!isServer) exitWith {};

params ["_num"];

private _units = units (missionNamespace getVariable ["un_check" + str _num + "_units", grpNull]);
private _objects = missionNamespace getVariable ["un_check" + str _num + "_objects_delete", []];
private _apcs = missionNamespace getVariable ["un_check" + str _num + "_apc", []];

deleteMarker ("un_check" + str _num);

if (typeName _apcs != "ARRAY") then {
	_apcs = [_apcs];
};

{_x enableAi "ALL";} forEach _units;

(_units + _objects) spawn MALO_fnc_deleteObjects;

{_x setVehicleAmmo 0;} forEach _apcs;