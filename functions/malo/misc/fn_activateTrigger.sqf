// ACTIVATES A TRIGGER INSTANTLY

if (false) exitWith {};

params ["_trg"];

_statements = triggerStatements _trg;
_statements set [0, "this"];

_trg setTriggerStatements _statements;
_trg setTriggerActivation ["ANY", "NOT PRESENT", false];
_trg setTriggerTimeout [0, 0, 0, false];
_trg setTriggerArea [0, 0, 0, false, 0];