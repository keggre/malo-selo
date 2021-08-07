// DEFINES TASKS AT THE START OF THE GAME

if (false) exitWith {};

player createDiaryRecord ["Diary", ["Introduction", "Welcome to Malo Selo!"]];

[
	east, 
	"end_mission", 
	["All the villages must be captured in order to complete the scenario.", "Capture the Bosnian villages"],
	ObjNull,
	"CREATED",
	nil,
	nil,
	"ATTACK",
	nil,
	false

] call BIS_fnc_taskCreate;