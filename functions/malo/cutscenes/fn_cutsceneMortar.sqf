// CUTSCENE THAT PLAYS WHILE THE MORTAR SHELLS LAND

if (!hasInterface) exitWith {};
if (MALO_CFG_enable_cutscenes == false) exitWith {};

sleep 40;

private _camera = "camera" camCreate [4231.22,5803.2,43.1528];
_camera camPrepareTarget mortar_cutscene_tgt;
_camera cameraEffect ["internal", "back"];
_camera camCommitPrepared 0;
waitUntil { camCommitted _camera };

sleep 15;
_camera cameraEffect ["terminate", "back"];
camDestroy _camera;