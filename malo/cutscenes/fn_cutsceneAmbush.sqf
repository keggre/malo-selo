// CUTSCENE THAT PLAYS WHEN THE BOSNIAN AMBUSH BEGINS

if (!hasInterface) exitWith {};
if (MALO_CFG_enable_cutscenes == false) exitWith {};

private _camera = "camera" camCreate [4103.72,5712.99,15.5245];
_camera camPrepareTarget ambush_cutscene_tgt;
_camera cameraEffect ["internal", "back"];
_camera camCommitPrepared 0;
waitUntil { camCommitted _camera };

sleep 3;
_camera cameraEffect ["terminate", "back"];
camDestroy _camera;