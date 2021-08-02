// DEALS WITH INTERNATIONAL OPINION

if (!isServer) exitWith {};

private _init = missionNamespace getVariable ["MALO_init_internationalOpinion", false];


// INIT

if (!_init && ("shootout" in MALO_mission_progress)) then {

	// DEFINE EVENTS
	MALO_intervention_events = [
		["plane", {
			sleep (random [0, 30, 60]);
			"NATO is deploying air support to the area as retaliation against our war crimes." remoteExec ["hint", 0];
			private _plane = createVehicle ["CFP_B_USARMY_1991_A10A_Thunderbolt_II_WDL_01", [0, 10000, 600], [], 0, "FLY"];
			private _crew = createVehicleCrew _plane;
			_crew addWaypoint [(getMarkerPos "shakhovka"), 3000];
			sleep (random [450, 600, 750]);
			_crew addWaypoint [[10000, 10000, 600], 0];
			private _group = createGroup independent;
			(units _crew) joinSilent _group;
			[driver _plane, _plane] spawn MALO_fnc_deleteObjects;
		}, 50]
	];

	// DEFINE OPINION FACTORS
	MALO_international_opinion_factors = [
		["msta", {missionNamespace getVariable ["msta_serb", false]}, -50]
	];
	
	// SET VARIABLES
	if ((MALO_CFG_loading == true) /*&& hasInterface*/) then {
		missionNamespace setVariable ["MALO_international_opinion", (profileNamespace getVariable ["MALO_saved_international_opinion", 0]), true];
		MALO_international_opinion_loading_handle = [] spawn {
			private _i = 0;
			for "_i" from 0 to 60 do {
				missionNamespace setVariable ["MALO_international_opinion", (profileNamespace getVariable ["MALO_saved_international_opinion", 0]), true];
				sleep 1;
			};
		};
	} else {
		missionNamespace setVariable ["MALO_international_opinion", 0, true];
		MALO_international_opinion_loading_handle = [] spawn {};
	};
	missionNamespace setVariable ["MALO_last_international_intervention", time, true];
	missionNamespace setVariable ["MALO_international_intervention_in_progress", false, true];

	{

		// DETERMINE IF UNIT IS ARMED OR UNARMED
		if (alive _x) then {
			if (_x call MALO_fnc_isArmed) then {
				_x setVariable ["armed", true, true];
			} else {
				_x setVariable ["armed", false, true];
			};
		};

		// ADD EVENT HANDLER FOR WHEN CIVS ARE KILLED
		_x addEventHandler ["Killed", {
			private _unit = (_this select 0);
			private _armed = _unit getVariable ["armed", true];
			if (!_armed) then {
				MALO_international_opinion = MALO_international_opinion - 1;
			};
		}];

	} forEach allUnits;

	// COMPILE FUNCTIONS
	{
		private _name = _x select 0;
		private _code = _x select 1;
		call compile ("
			MALO_fnc_internationalOpinion_" + _name + " = " + str _code + ";
		");
	} forEach MALO_intervention_events;

	missionNamespace setVariable ["MALO_init_internationalOpinion", true, true];


	// SPAWN OPINION FACTOR FUNCTIONS
	{
		_x spawn {
			private _name = (_this select 0);
			private _condition = (_this select 1);
			private _value = (_this select 2);
			waitUntil _condition;
			MALO_international_opinion = MALO_international_opinion + _value;
		};
	} forEach MALO_international_opinion_factors;

};

if (!_init) exitWith {};


// EVENTS

private _random = random [450, 600, 750];
private _elapsed = time - MALO_last_international_intervention;

if ((_random < _elapsed) && !MALO_international_intervention_in_progress) then {

	MALO_potential_intervention_events = [];

	{
		private _name = _x select 0;
		private _value = _x select 2;
		if ((MALO_international_opinion + _value) < 0) then {
			MALO_potential_intervention_events append [_x];
		};
	} forEach MALO_intervention_events;

	if ((count MALO_potential_intervention_events) > 0) then {
		private _event = selectRandom MALO_potential_intervention_events;
		private _name = _event select 0;
		private _value = _event select 2;
		MALO_international_intervention_in_progress = true;
		MALO_international_opinion = MALO_international_opinion + (_value / 2);
		call compile ("MALO_current_international_intervention_event = [] spawn MALO_fnc_internationalOpinion_" + _name + ";");
	};

} else {

	if (MALO_international_intervention_in_progress) then {
		if (scriptDone MALO_current_international_intervention_event) then {
			MALO_international_intervention_in_progress = false;
			MALO_last_international_intervention = time;
		};
	};

};


// BROADCAST AND SAVE OPINION VARIABLE

publicVariable "MALO_international_opinion";

if (scriptDone MALO_international_opinion_loading_handle) then {
	private _fnc = {
		// if (!hasInterface) exitWith {};
		if (MALO_CFG_saving == true) then {
			profileNamespace setVariable ["MALO_saved_international_opinion", MALO_international_opinion]
		};
	};
	[] remoteExec ["_fnc"];
};