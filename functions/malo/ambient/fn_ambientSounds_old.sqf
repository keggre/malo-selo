// PLAYS AMBIENT SOUNDS NEAR PLAYERS

if (!isServer) exitWith {};

[] spawn {

	MALO_fnc_ambientSounds_getDistanceToNearestEnemyVillage = {
		private _village_1 = _this;
		private _serb_1 = missionNamespace getVariable [(_village_1 + "_serb"), false];
		private _position_1 = getMarkerPos _village_1;
		private _distances = [5000];
		{
			private _village_2 = _x;
			private _serb_2 = missionNamespace getVariable [(_village_2 + "_serb"), false];
			private _position_2 = getMarkerPos _village_2;
			if (_serb_1 != _serb_2) then {
				_distances append [(_position_1 distance _position_2)];
			};
		} forEach villages;
		private _min = selectMin _distances;
		_min
	};

	MALO_fnc_ambientSounds_selectPosition = {
		private _village = selectRandom villages;
		private _distance = _village call MALO_fnc_ambientSounds_getDistanceToNearestEnemyVillage;
		private _position = [[[getMarkerPos _village, _distance]],[]] call BIS_fnc_randomPos;
		_position
	};

	private _center = createCenter sideLogic;
	private _group = createGroup _center;
	private _logic = _group createUnit ["LOGIC", [0,0,0], [], 0, ""];

	/*private _marker = createMarker ["ambient_sound_marker", [0,0,0]];
	_marker setMarkerType "dot";*/

	while {MALO_CFG_ambient_sounds} do {

		private _position = [0,0,0];

		while {MALO_CFG_ambient_sounds} do {
			_position = call MALO_fnc_ambientSounds_selectPosition;
			if (_position distance (_position call MALO_fnc_getNearestPlayer) > 500) exitWith {};
		};

		private _sound_1 = format ["A3\Sounds_F\ambient\battlefield\battlefield_explosions%1.wss", floor (random 4)+1];
		private _sound_2 = format ["A3\Sounds_F\ambient\battlefield\battlefield_firefight%1.wss", floor (random 2)+2];
		private _sound = (
			if (selectRandom [0,1,2] == 0) then {
				_sound_1
			} else {
				_sound_2
			}
		);

		_logic setPos _position;
		playSound3D [_sound, _logic, false, position _logic, 5];

		/*_marker setmarkerPos _position;*/

		sleep (random [0,5,15]);

	};

};