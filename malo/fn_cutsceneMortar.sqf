sleep 33;

private _camera = "camera" camCreate [4231.22,5803.2,43.1528];
_camera camPrepareTarget mortar_cutscene_tgt;
_camera cameraEffect ["internal", "back"];
_camera camCommitPrepared 0;
waitUntil { camCommitted _camera };

sleep 20;
_camera cameraEffect ["terminate", "back"];
camDestroy _camera;