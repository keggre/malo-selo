if (!isServer) exitWith {};

params ["_village"];

call compile ("

	private _marker = createMarker ['respawn_east_" + _village + "', getMarkerPos '" + _village + "_spawn']; 
	_marker setMarkerType 'respawn_unknown'; 
	_marker setmarkercolor 'coloreast'; 
	_marker setMarkerText ( markerText '" + _village + "_spawn');
	_marker setMarkerAlpha 0;

");