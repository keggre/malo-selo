// CUTSCENE THAT PLAYS AT THE START OF THE MISSION

if (!hasInterface) exitWith {};
if (false) exitWith {};

titleText [("<t size='2'> A small village in Republika Srpska, 1993 </t>"), "PLAIN DOWN", -1, true, true];

private _camera = "camera" camCreate [4322.65,5830.28,65.8712];
_camera camPrepareTarget opening_cutscene_tgt;
_camera cameraEffect ["internal", "back"];
_camera camCommitPrepared 0;

uisleep 3;

waitUntil {MALO_init == false};

titleFadeOut 1;

_camera cameraEffect ["terminate", "back"];
camDestroy _camera;