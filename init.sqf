fn_config = execVM "config.sqf";
waitUntil {scriptDone fn_config};

call skhpersist_fnc_initializeSaveSystem;

fn_main = [] spawn MALO_fnc_main;