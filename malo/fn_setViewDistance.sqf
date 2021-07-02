params ["_modifier", "_is_reducer"];

_distance = (_modifier select 0);
_position = (_modifier select 1);
_radius = (_modifier select 2);

if (player distance _position < _radius) then {

	if (_is_reducer == true && next_view_distance > _distance) then {
	
		next_view_distance = _distance;

	} else {

		if (next_view_distance < _distance) then {

			next_view_distance = _distance;

		}

	}

}