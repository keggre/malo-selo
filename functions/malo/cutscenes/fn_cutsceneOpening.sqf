// CUTSCENE THAT PLAYS AT THE START OF THE MISSION

if (!hasInterface) exitWith {};
if (false) exitWith {};

setViewDistance MALO_current_view_distance;
0 setFog MALO_fog_value;
0 setOvercast MALO_ovc_value;

private _camera = "camera" camCreate [4322.65,5830.28,65.8712];
_camera camPrepareTarget opening_cutscene_tgt;
_camera cameraEffect ["internal", "back"];
_camera camCommitPrepared 0;

onPreloadFinished {
	onPreloadFinished "";
	["MALO_loading", "Loading mission..."] call BIS_fnc_startLoadingScreen;
};

waitUntil {MALO_init == false};

"MALO_loading" call BIS_fnc_endLoadingScreen;

titleText [("<t size='2'> A small village in Republika Srpska, 1993 </t>"), "PLAIN DOWN", -1, true, true];

uisleep 4;

titleFadeOut 1;

uisleep 1;

_camera cameraEffect ["terminate", "back"];
camDestroy _camera;

MALO_current_view_distance = 500;
MALO_next_view_distance = 500;