if (false) exitWith {};

{

	_serb = call compile (_x + "_serb");

	if (_serb == true) then {

		_x setMarkerType "o_hq"; 

	} else {

		_x setMarkerType "b_hq"; 

	};

} forEach villages;