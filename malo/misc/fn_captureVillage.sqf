/* "guglovo" setMarkerType "o_hq";  trg_poi4 setTriggerArea [5000,5000,0,false,100];  trg_poi5 setTriggerArea [5000,5000,0,false,100]; trg_poi6 setTriggerArea [5000,5000,0,false,100]; guglovo_flag setFlagTexture ""; hint "We have captured Guglovo"; guglovo_marker setDamage 1; {_x enableAi "PATH";} forEach units un_check1_units; {_x enableAi "PATH";} forEach units un_check2_units; un_check1_apc setVehicleAmmo 0; [cap_1, "cap_marker_1"] spawn MALO_fnc_capsquads; */

params["_name"];

// SET [VILLAGE]_SERB TRUE
call compile (_name + "_serb = true;");

// CREATE LOCAL VARIABLES FROM THE VILLAGE GLOBAL VARIABLES
_pois = call compile (_name + "_pois");
_capsquad_nums = call compile (_name + "_capsquad_nums");

// ACTIVATE THE POI TRIGGERS
{
	_trg = missionNamespace getVariable ("trg_" + _x);
	_trg setTriggerArea [5000,5000,0,false,100]; 
} forEach _pois;

// CHANGE THE VILLAGE FLAG TEXTURE
call compile (_name + "_flag setFlagTexture 'img\srpska.jpg';");

// NOTIFY THE USER THAT THE VILLAGE HAS BEEN CAPTURED
call compile ("hint ('We have captured ' + " + _name + "_fullname + '.');");

// KILL OFF THE VILLAGE MARKER (ACTUALLY A UNIT)
call compile (_name + "_marker setDamage 1;");

// ACTIVATE THE VILLAGE CAPSQUADS
{
	call compile ("[cap_" + str _x + ", getMarkerPos 'cap_marker_" + str _x + "'] spawn MALO_fnc_capsquads;");
} forEach _capsquad_nums;

// MAKE GUGLOVO UN GUYS RETREAT
if (_name == "guglovo") then {
	{_x enableAi "PATH";} forEach units un_check1_units; 
	{_x enableAi "PATH";} forEach units un_check2_units; 
	un_check1_apc setVehicleAmmo 0; 
};