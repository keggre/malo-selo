fn_config = execVM "config.sqf";
waitUntil {scriptDone fn_config};

fn_main = [] spawn MALO_fnc_main;