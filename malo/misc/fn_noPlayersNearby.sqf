// CREATES TRIGGER FOR WHEN PLAYERS ARE NOT PRESENT

if (false) exitWith {};

params ["_code", "_position", "_radius"];

private _string = str _code;

private _trg = createTrigger ["EmptyDetector", _position];
_trg setTriggerArea [_radius, _radius, 0, false];
_trg setTriggerActivation ["ANYPLAYER", "NOT PRESENT", false];
_trg setTriggerStatements ["this", _string, ""];