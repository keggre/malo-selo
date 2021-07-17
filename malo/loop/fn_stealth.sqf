// STOPS AI HOSTILITY IF CERTAIN CONDITIONS ARE MET

if (!hasInterface) exitWith {};

private _max_distance = 50;
private _max_cooldown = 60;

private _uniforms = MALO_serb_uniforms;
private _vehicles = MALO_serb_vehicles;


// FIND OUT IF PLAYER IS ARMED OR NOT

player setVariable ["armed", (player call MALO_fnc_isArmed), true];


// GET PLAYER VARIABLES

private _armed = player getVariable ["armed", false];
private _cooldown = player getVariable ["cooldown", _max_cooldown];


// GET PLAYER'S UNIFORM AND PLAYER'S VEHICLE

private _uniform = uniform player;
private _vehicle = typeOf vehicle player;


// BASE VALUE

private _stealth = .5;


// MODIFIERS

if (_uniform in _uniforms) then {
	_stealth = _stealth - .5;
} else {
	_stealth = _stealth + .5;
};

if !((_vehicle in _vehicles) || ((vehicle player) == player)) then {
	_stealth = _stealth + .5;
};

if (_armed && ((vehicle player) == player)) then {
	_stealth = _stealth - .25;
};


// LOWER LIMIT

if (_stealth < 0) then {
	_stealth = 0;
};


// UPPER LIMIT

if (_stealth > 1) then {
	_stealth = 1;
};

// APPLY VARIABLE

player setVariable ["stealth", _stealth, true];


// SEEN OR NOT SEEN

if !(_stealth == 0 || _stealth == 1) then {
	private _condition = false;
	{
		if (side _x == west && (_x knowsAbout player > _stealth * 4)) then {
			_condition = true;
		};
	} forEach nearestObjects [player, [], _max_distance];

	if (_condition) then {
		_stealth = 0;
	} else {
		_stealth = 1;
	};
};


// EVENT HANDLERS THAT RESET STEALTH

private _events = [
	"firedMan",
	"firedNear",
	"take"
];

{
	if !(player getVariable [(_x + "EventCreated"), false]) then {
		player setVariable [(_x + "EventCreated"), true, true];
		call compile ("
			player addEventHandler ['" + _x + "', {
				private _fnc = {
					params ['_unit'];
					_unit setVariable ['cooldown', 0, true];
					sleep 5;
					_unit setVariable [('" + _x + "' + 'EventCreated'), false, true];
					private _stealth = _unit getVariable ['stealth', 0];
				};
				(_this select 0) spawn _fnc;
			}];
		");
	};
} forEach _events;

{
	if ((side _x == west) && !(_x getVariable ["killedStealthEventCreated", false])) then {
		_x setVariable ["killedStealthEventCreated", true, true];
		_x addEventHandler ["Killed", {
			private _unit = _this select 0;
			private _player = _unit call MALO_fnc_getClosestPlayer;
			if ((_unit distance _player) < 50) then {
				_player setVariable ["cooldown", 0, true];
			};
			_x setVariable ["killedStealthEventCreated", false, true];
		}];
	};
} forEach (nearestObjects [player, ["MAN"], 50]);


// ADD OR RESET COOLDOWN

if ((_stealth == 1) && alive player) then {
	player setVariable ["cooldown", _cooldown + MALO_delay + .1, true];
} else {
	player setVariable ["cooldown", 0, true];
};


// CONCLUSION

if (player getVariable ["cooldown", 0] > _max_cooldown) then {
	player setVariable ["cooldown", _max_cooldown, true];
	player setCaptive true;
} else {
	player setCaptive false;
};