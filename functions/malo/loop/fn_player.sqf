// RUNS LOCALLY

if (!hasInterface) exitWith {};
if (MALO_init == true) exitWith {};


// VARIABLES

{player setVariable [_x, (missionNamespace getVariable [_x, 0]), true]} forEach [
	"MALO_simulation_distance",
	"MALO_current_view_distance",
	"MALO_next_view_distance",
	"MALO_fog_value",
	"MALO_ovc_value"
];


// PREVENTS PLAYERS FROM BEING KILLED BY FRIENDLY AI BECAUSE OF TEAMKILLING OR CIVILIAN KILLS

if (MALO_CFG_allow_war_crimes == true) then {
	if ((rating player < 0)) then {
		player addRating abs (rating player)
	};
};


// MARK AS RETURNING PLAYER

profileNamespace setVariable ["MALO_returning_player", true];


// SAVE INVENTORY

[player, [profileNamespace, "MALO_saved_inventory"]] call BIS_fnc_saveInventory;


// CREATE EVENT HANDLERS FOR PROFILE NAMESPACE SAVING

private _events = [
	"take"
];

{
	if !(player getVariable [(_x + "SaveEventCreated"), false]) then {
		player setVariable [(_x + "SaveEventCreated"), true, true];
		call compile ("
			player addEventHandler ['" + _x + "', {
				saveProfileNamespace;
				private _unit = _this select 0;
				_unit setVariable [('" + _x + "' + 'SaveEventCreated'), false, true];
				_unit removeEventHandler ['" + _x + "', _thisEventHandler];
			}];
		");
	};
} forEach _events;


// SIMULATION

{_x enableSimulationGlobal true;} forEach units player_squad;


// VOICE

private _speaker = "RHS_Male03CZ";
if (speaker player != _speaker) then {
	player setSpeaker _speaker;
};


// MAKE DEATH MARKERS

if !(player getVariable ["killedMarkerEventCreated", false]) then {

	player setVariable ["killedMarkerEventCreated", true, true];
	
	player addEventHandler ["Killed", {
		
		private _player = (_this select 0);
		private _position = position _player;

		private _marker = createMarkerLocal [((str (owner _player)) + "_death_t_" + (str time)), _position];
		
		_marker setMarkerTypeLocal "mil_destroy";
		_marker setMarkerColorLocal "ColorBlackAlpha";
		_marker setMarkerDirLocal 45;
		_marker setMarkerSizeLocal [.5, .5];

		private _fnc = {

			params ["_marker"];
			
			sleep 600;

			_i = 0;
			for "_i" from 0 to 100 do {
				_marker setMarkerAlphaLocal (1 - (_i / 100));
				uisleep .05;
			};

			deleteMarkerLocal _marker;

		};

		_marker spawn _fnc;

	}];

};

