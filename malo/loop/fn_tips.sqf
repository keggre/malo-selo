// DEALS WITH HINTS

if (!hasInterface) exitWith {};

MALO_tips = [

	// MISSION LOADING
	["saving_enabled", "Saving enabled. Mission progress will be saved automatically.", true],
	["saving_disabled", "Saving not enabled. Mission progress will not be saved!", true],
	["progress_loaded", "Mission progress loaded.", true],

	// GAMEPLAY TIPS
	["log", 'A log of the mission hints can be found by pressing "m" and clicking "briefing -> hints" in the top left corner of the screen.', false],
	["inventory", "Inventory items except for weapons and ammunition persist through respawns. Clothing items such as uniforms, vests or backpacks only need to be picked up once.", false],
	["low_fps", 'You can adjust settings to improve performance in the pause menu under "Configuration -> Addon Options -> Malo Selo"', false],
	["stealth", "Enemies are less likely to detect you when wearing civilian clothes or driving civilian vehicles. Keep a low profile to avoid being spotted entirely.", false],
	["repair", "Toolkits are available in most vehicles and can be used to repair your vehicle.", false],
	["mines", "Nearby landmines are marked on the map.", false],

	// MISSION OR VILLAGE SPECIFIC
	["guglovo", "Bosnian villages that have been discovered by your team will appear as blue flags on the map. All of these must be captured in order to complete the scenario.", false],
	["msta", "Msta is a village protected by the UNPROFOR, attacking the village will likely provoke NATO retaliation", false],
	["tank_delivered", "Pusta has been set up as an operations base for attacking the Bosnian stronghold of Electrozavodsk. Here you can find various types of hardware to help in the attack", false]

];

if !(missionNamespace getVariable ["MALO_tips_loaded", false]) then {

	player addEventHandler ["take", {

		MALO_TIP_inventory = true;
		
		(_this select 0) removeEventHandler ["take", _thisEventHandler];

	}];

};

private _fnc = {

	waitUntil {!MALO_init};
	sleep 5;

	MALO_TIP_log = true;

	if (diag_fps < 20) then {
		MALO_TIP_low_fps = true;
	};

	if ((player getVariable ["stealth", 0]) >= .25) then {
		MALO_TIP_stealth = true;
	};

};

[] spawn _fnc;

if (((vehicle player) != player) && (damage (vehicle player) > .2)) then {

	MALO_TIP_repair = true;

};


// LOAD ALREADY SEEN TIPS FROM PROFILE NAMESPACE

if !(missionNamespace getVariable ["MALO_tips_loaded", false]) then {

	// FIND THE PROFILE NAMESPACE VARIABLE IF EXISTS
	if (MALO_CFG_loading) then {
		MALO_shown_tips = profileNamespace getVariable ["MALO_saved_shown_tips", []];
	} else {
		MALO_shown_tips = [];
	};

	// BROADCAST ALREADY SEEN TIPS FROM HOST
	if (isServer && hasInterface) then {
		MALO_server_shown_tips = MALO_shown_tips;
		publicVariable "MALO_server_shown_tips";
	};

	// CREATE DIARY RECORDS FOR ALREADY SEEN TIPS
	{
		private _name = (_x select 0);
		private _text = (_x select 1);
		if (_name in MALO_shown_tips) then {
			player createDiaryRecord ["Diary", ["Hints", _text]];
		};
	} forEach MALO_tips;

	MALO_tips_loaded = true;

};


// LOAD ALREADY SEEN TIPS FROM THE SERVER

private _array = missionNamespace getVariable ["MALO_server_shown_tips", []];

private _condition_1 = ((count _array) > 0);
private _condition_2 = !(missionNamespace getVariable ["MALO_server_tips_loaded", false]);
private _condition_3 = (!isServer && hasInterface);

if (_condition_1 && _condition_2 && _condition_3) then {

	// FIND SHOWN TIPS FROM SERVER THAT HAVENT BEEN LOADED LOCALLY
	MALO_from_server_shown_tips = [];
	{
		if !(_x in MALO_shown_tips) then {
			MALO_from_server_shown_tips append [_x];
		};
	} forEach _array;

	// SET THE TIP VARIABLES TRUE
	{

		missionNamespace setVariable [("MALO_tip_" + _x), true, false];
	
	} forEach MALO_from_server_shown_tips;

	MALO_server_tips_loaded = true;

};


// LOOPING THROUGH ALL TIPS

{

	private _name = (_x select 0);
	private _text = (_x select 1);
	private _repeats = (_x select 2);

	private _condition_1 = (missionNamespace getVariable [("MALO_TIP_" + _name), false]);
	private _condition_2 = (missionNamespace getVariable ["MALO_show_tip", true]);
	private _condition_3 = !(_name in MALO_shown_tips) || _repeats;

	if (_condition_1 && _condition_2 && _condition_3) then {

		// CREATE THE HINT AND THE DIARY ENTRY
		hint _text;
		if !(_name in MALO_shown_tips) then {
			player createDiaryRecord ["Diary", ["Hints", _text]];
		};
		
		// SET THE TIP VARIABLE TO FALSE AND ADD THE TIP NAME TO THE LIST OF SHOWN TIPS
		missionNamespace setVariable [("MALO_TIP_" + _name), false, false];
		if !(_name in MALO_shown_tips) then {
			MALO_shown_tips append [_name];
		};

		// BLOCK OTHER TIPS FROM SHOWING UNTIL 30 SECONDS HAVE PASSED
		MALO_show_tip = false;
		private _fnc = {
			uisleep 30;
			MALO_show_tip = true;
		};
		[] spawn _fnc;

	};

} forEach MALO_tips;


// SAVE SHOWN TIPS

profileNamespace setVariable ["MALO_saved_shown_tips", MALO_shown_tips];


