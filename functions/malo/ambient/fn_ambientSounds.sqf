// PLAYS AMBIENT SOUNDS NEAR PLAYERS

if (!isServer) exitWith {};

[] spawn {

	MALO_fnc_ambientSounds_getDistanceToNearestBosnianVillage = {
		private _position = _this;
		private _distances = [];
		{
			private _village = _x;
			private _serb = missionNamespace getVariable [(_village + "_serb"), false];
			if (!_serb) then {
				_distances append [(_position distance (getMarkerPos _village))];
			};
		} forEach villages;
		private _min = selectMin _distances;
		_min
	};

	MALO_fnc_ambientSounds_selectPosition = {
		private _position = (
			while {MALO_CFG_ambient_sounds} do {
				private _village = (
					while {MALO_CFG_ambient_sounds} do {
						private _village = selectRandom villages; 
						if (
							missionNamespace getVariable [(_village + "_serb"), false]
						) exitWith {_village};
						sleep .1;
					}
				);
				private _position = [[[getMarkerPos _village, 2000]],[]] call BIS_fnc_randomPos;; 
				if (
					(_position call MALO_fnc_ambientSounds_getDistanceToNearestBosnianVillage < 2000) &&
					(_position distance (_position call MALO_fnc_getNearestPlayer) > 1000)
				) exitWith {_position};
			}
		);
		_position
	};

	private _center = createCenter sideLogic;
	private _group = createGroup _center;
	private _logic = _group createUnit ["LOGIC", [0,0,0], [], 0, ""];

	/**/private _marker = createMarker ["ambient_sound_marker", [0,0,0]];
	_marker setMarkerType "dot";/**/

	while {MALO_CFG_ambient_sounds} do {

		private _position = call MALO_fnc_ambientSounds_selectPosition;
		
		private _explosion = format ["A3\Sounds_F\ambient\battlefield\battlefield_explosions%1.wss", floor (random 4)+1];
		private _firefight = format ["A3\Sounds_F\ambient\battlefield\battlefield_firefight%1.wss", floor (random 2)+2];
		private _sound = (
			if (selectRandom [0,1,2] == 0) then {
				_explosion
			} else {
				_firefight
			}
		);

		_logic setPos _position;
		playSound3D [_sound, _logic, false, position _logic, 5];

		/**/_marker setmarkerPos _position;/**/

		sleep (random [
				5,
				10,
				60 + (
					60 *
					(
						abs (
							daytime - 12
						)
					) / 
					12
				)
			]
		);

	};

};