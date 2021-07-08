if (false) exitWith {};

params["_name"];

/* "guglovo" setMarkerType "o_hq";  trg_poi4 setTriggerArea [5000,5000,0,false,100];  trg_poi5 setTriggerArea [5000,5000,0,false,100]; trg_poi6 setTriggerArea [5000,5000,0,false,100]; guglovo_flag setFlagTexture ""; hint "We have captured Guglovo"; guglovo_marker setDamage 1; {_x enableAi "PATH";} forEach units un_check1_units; {_x enableAi "PATH";} forEach units un_check2_units; un_check1_apc setVehicleAmmo 0; [cap_1, "cap_marker_1"] spawn MALO_fnc_capsquads; */
/* "novy" setMarkerType "o_hq"; trg_poi7 setTriggerArea [5000,5000,0,false,100]; novy_flag setFlagTexture ""; hint "We have captured Novy Sobor"; novy_marker setDamage 1;  [cap_2, "cap_marker_2"] spawn MALO_fnc_capsquads; [cap_3, "cap_marker_3"] spawn MALO_fnc_capsquads; {_x enableAi "ALL";} forEach units t_enemy_1;  {_x enableAi "ALL";} forEach units t_enemy_2; {_x enableAi "ALL";} forEach units t_friendly_1;*/
/* "msta" setMarkerType "o_hq"; hint "We have captured Msta"; us_plane_1 enableSimulation true; trg_poi8 setTriggerArea [5000,5000,0,false,100]; trg_poi9 setTriggerArea [5000,5000,0,false,100]; msta_marker setDamage 1; {_x enableAi "PATH";} forEach units un_check3_units; {_x enableAi "PATH";} forEach units un_check4_units; {_x enableAi "PATH";} forEach units un_check5_units; un_check3_apc setVehicleAmmo 0; un_check4_apc setVehicleAmmo 0; un_check5_apc setVehicleAmmo 0;  [cap_6, "cap_marker_6"] spawn MALO_fnc_capsquads; [cap_7, "cap_marker_7"] spawn MALO_fnc_capsquads; */
/* "pusta" setMarkerType "o_hq"; hint "We have captured Pusta"; pusta_flag setFlagTexture ""; pusta_marker setDamage 1; [cap_8, "cap_marker_8"] spawn MALO_fnc_capsquads; [cap_9, "cap_marker_9"] spawn MALO_fnc_capsquads; {_x enableAi "ALL";} forEach units t_enemy_3;*/
/* "stary" setMarkerType "o_hq"; stary_flag setFlagTexture ""; hint "We have captured Stary Sobor"; stary_marker setDamage 1; [cap_4, "cap_marker_4"] spawn MALO_fnc_capsquads; [cap_5, "cap_marker_5"] spawn MALO_fnc_capsquads;*/

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

// ADD TO MISSION PROGRESS
[_name] spawn MALO_fnc_savePush;

// UN RETREAT FOR GUGLOVO
if (_name == "guglovo") then {
	{_x enableAi "PATH";} forEach units un_check1_units; 
	{_x enableAi "PATH";} forEach units un_check2_units; 
	un_check1_apc setVehicleAmmo 0; 
};

// TRENCH FALLBACKS FOR NOVY
if (_name == "novy") then {
	{_x enableAi "ALL";} forEach units t_enemy_1;  
	{_x enableAi "ALL";} forEach units t_enemy_2; 
	{_x enableAi "ALL";} forEach units t_friendly_1;
};

// ACTIVATE PLANE AND UN RETREAT FOR MSTA
if (_name == "msta") then {
	us_plane_1 enableSimulation true;
	{_x enableAi "PATH";} forEach units un_check3_units; 
	{_x enableAi "PATH";} forEach units un_check4_units; 
	{_x enableAi "PATH";} forEach units un_check5_units; 
	un_check3_apc setVehicleAmmo 0; 
	un_check4_apc setVehicleAmmo 0; 
	un_check5_apc setVehicleAmmo 0;
};

// TRENCH FALLBACK FOR PUSTA
if (_name == "pusta") then {
	{_x enableAi "ALL";} forEach units t_enemy_3;
};

// STARY
if (_name == "stary") then {
	// nothing yet
};