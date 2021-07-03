{

	_name = (_x select 0);
	_serb = (_x select 1);

	if (_serb == true) then {

		_name setMarkerType "o_hq"; 

	} else {

		_name setMarkerType "b_hq"; 

	}

} forEach villages;
