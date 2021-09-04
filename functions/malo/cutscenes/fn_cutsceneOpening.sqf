// CUTSCENE THAT PLAYS AT THE START OF THE MISSION

if (!hasInterface) exitWith {};
if (false) exitWith {};

setViewDistance MALO_current_view_distance;
0 setFog MALO_fog_value;
0 setOvercast MALO_ovc_value;

MALO_cutscene_camera = "camera" camCreate [4322.65,5830.28,65.8712];
MALO_cutscene_camera camPrepareTarget opening_cutscene_tgt;
MALO_cutscene_camera cameraEffect ["internal", "back"];
MALO_cutscene_camera camCommitPrepared 0;

MALO_fnc_cutsceneOpening_spawned = {

	"MALO_loading" call BIS_fnc_endLoadingScreen;

	titleText [("<t size='2'> A small village in Republika Srpska, 1993 </t>"), "PLAIN DOWN", -1, true, true];

	uisleep 4;

	titleFadeOut 1;

	uisleep 1;

	MALO_cutscene_camera cameraEffect ["terminate", "back"];
	camDestroy MALO_cutscene_camera;

	MALO_current_view_distance = 500;
	MALO_next_view_distance = 500;

};

onPreloadFinished {

	onPreloadFinished "";

	["MALO_loading", "Loading mission..."] call BIS_fnc_startLoadingScreen;

	waitUntil {(missionNamespace getVariable ["MALO_init", true]) == false};

	[] spawn MALO_fnc_cutsceneOpening_spawned;

};