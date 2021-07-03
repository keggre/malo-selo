/* "guglovo" setMarkerType "o_hq";  trg_poi4 setTriggerArea [5000,5000,0,false,100];  trg_poi5 setTriggerArea [5000,5000,0,false,100]; trg_poi6 setTriggerArea [5000,5000,0,false,100]; guglovo_flag setFlagTexture ""; hint "We have captured Guglovo"; guglovo_marker setDamage 1; {_x enableAi "PATH";} forEach units un_check1_units; {_x enableAi "PATH";} forEach units un_check2_units; un_check1_apc setVehicleAmmo 0; [cap_1, "cap_marker_1"] spawn MALO_fnc_capsquads; */

params["_name"];

_village = villages select (villages find _name);

_village set [1, true];

_pois = (_village select 2);
_capsquad_nums = (_village select 3);

{

	_trg = missionNamespace getVariable ("trg_" + _x);

	_trg setTriggerArea [5000,5000,0,false,100]; 

} forEach _pois;

(missionNamespace getVariable (_name + "_flag")) setFlagTexture "";

hint ("We have captured " + _name); 

(missionNamespace getVariable (_name + "_marker")) setDamage 1;

{

	[(missionNamespace getVariable ("cap_" + _x)), (missionNamespace getVariable ("cap_marker_" + _x))] spawn MALO_fnc_capsquads;

} forEach _capsquad_nums;

if (_name == "guglovo") then {
	{_x enableAi "PATH";} forEach units un_check1_units; 
	{_x enableAi "PATH";} forEach units un_check2_units; 
	un_check1_apc setVehicleAmmo 0; 
}