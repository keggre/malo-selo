// PREVENTS A TRIGGER FROM BEING ACTIVATED

if (false) exitWith {};

params ["_trg"];

_statements = triggerStatements _trg;
_statements set [0, "false"];

_trg setTriggerStatements _statements;