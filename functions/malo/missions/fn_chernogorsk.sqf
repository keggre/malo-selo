if (false) exitWith {};

if (missionNamespace getVariable ["chernogorsk_serb", false]) exitWith {};
if !(missionNamespace getVariable ["chernogorsk_discovered", false]) exitWith {};

MALO_fnc_chernogorsk_arty = {

	if (!isServer) exitWith {};

	

};

fn_chernogorsk_arty = [] spawn MALO_fnc_chernogorsk_arty;

while {!(missionNamespace getVariable ["chernogorsk_serb", false])} do {};

terminate fn_chernogorsk_arty;