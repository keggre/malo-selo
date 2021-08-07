// HIDES OR SHOWS OBJECTS

if (!isServer) exitWith {false};

params ["_objects", "_hide", "_preset"];

if (isNil _preset) then {
	_preset = 0;
};

private _vals = (switch (_preset) do {
	case 1: {[true, true, false]};		// CAPSQUADS
	case 2: {[true, false, true]}; 		// JEEPS
	default {[true, false, false]};
});

_vals params ["_dynamic_simulation", "_enable_ai", "_vehicle_respawn"];

{
	private _vehicle = vehicle _x;
	private _group = group _vehicle;
	private _hiddden = _vehicle getVariable ["hidden", !_condition];
	if (_hidden != _hide) then {
		_vehicle hideObjectGlobal !_hidden;
		_vehicle enableSimulationGlobal _hidden;
		_vehicle enableDynamicSimulation _hidden && _dynamic_simulation;
		_group enableDynamicSimulation _hidden && _dynamic_simulation;
		if (_hidden && _enable_ai) then {
			_vehicle enableAi "ALL";
		};
		if (_hidden && _vehicle_respawn) then {
			vehicle_respawn_1 synchronizeObjectsAdd _vehicle;
		};
		_vehicle setVariable ["hidden", !_hidden, true];
	};
} forEach _objects;

true