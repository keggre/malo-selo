// STOPS AI HOSTILITY IF CERTAIN CONDITIONS ARE MET

if (!hasInterface) exitWith {};

private _max_distance = 50;
private _max_cooldown = 60;

private _uniforms = [];
private _vehicles = [];

private _safe_weapons = [];


// FIND OUT IF PLAYER IS ARMED OR NOT

player setVariable ["armed", (player call MALO_fnc_isArmed), true];



// GET PLAYER VARIABLES

private _armed = player getVariable ["armed", false];
private _cooldown = player getVariable ["cooldown", 0];


// GET PLAYER'S UNIFORM AND PLAYER'S VEHICLE

private _uniform = uniform player;
private _vehicle = vehicle player;


// BASE VALUE

private _stealth = 0;


// POSITIVE MODIFIERS

if !(_uniform in _uniforms) then {
	_stealth = _stealth + 1;
};

if !((_vehicle in _vehicles) || ((vehicle player) == player)) then {
	_stealth = _stealth + .5;
};


// UPPER LIMIT

if (_stealth > 1) then {
	_stealth = 1;
};


// NEGATIVE MODIFIERS

if (_armed) then {
	_stealth = _stealth - .5;
};


// LOWER LIMIT

if (_stealth < 0) then {
	_stealth = 0;
};


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
				player setVariable ['cooldown', 0, true];
				player setVariable [('" + _x + "' + 'EventCreated'), false, true];
			}];
		");
	};
} forEach _events;


// ADD OR RESET COOLDOWN

if ((_stealth == 1) && alive player) then {
	player setVariable ["cooldown", _cooldown + MALO_delay, true];
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