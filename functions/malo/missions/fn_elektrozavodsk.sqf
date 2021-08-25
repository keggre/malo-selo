if (false) exitWith {};

if (missionNamespace getVariable ["elektrozavodsk_serb", false]) exitWith {};
if !(missionNamespace getVariable ["elektrozavodsk_discovered", false]) exitWith {};

private _stages = [
	[1, "power station"],
	[2, "UN compound"],
	[3, "destroy the IFV"],
	[4, "train station"],
	[5, "factory"],
	[6,	"warehouse"],
	[7, "ARBiH headquarters"]
];

{

	private _num = _x select 0;
	private _taskname = _x select 1;
	private _name = ("e_obj_" + (str _num));
	private _trigger = missionNamespace getVariable [("trg_e_obj_" + (str _num)), objNull];
	private _unit = missionNamespace getVariable [("e_marker_" + (str _num)), objNull];
	private _group = missionNamespace getVariable [("e_squad_obj_" + (str _num)), grpNull];
	private _capleader = missionNamespace getVariable [("cap_e_" + (str _num)), objNull];
	private _capmarker = ("cap_marker_e_" + (str _num));

	/*[
		east,
		[_name, "vil"],
		[_taskname, ""],

	] call BIS_fnc_taskCreate;*/

	waitUntil {triggerActivated _trigger};

	_unit setDamage 1; 
	{_x enableAi "PATH";} forEach units _group; 
	[_capleader, getMarkerPos _marker] spawn MALO_fnc_capsquads; 
	[_name] spawn MALO_fnc_createRespawn;
	[_name] spawn MALO_fnc_saveKeyword; 

	if !(_num == 1) then {
		deleteMarker ("respawn_east_e_obj_" + (str (_num - 1)));
	};

	if (_num == 2) then {
		MALO_international_opinion = MALO_international_opinion - 50;
	};

} forEach _stages;

private _statements = triggerStatements trg_elektrozavodsk;
trg_elektrozavodsk setTriggerStatements ["this", _statements select 1, _statements select 2];