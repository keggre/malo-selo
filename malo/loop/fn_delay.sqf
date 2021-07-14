// ADJUSTS THE MAIN LOOP DELAY BASED OFF OF FRAMERATE

if (!hasInterface) exitWith {};

if (diag_fps + 5 < MALO_CFG_target_framerate) then {

	MALO_delay = (MALO_delay * 1.25);

} else {

	MALO_delay = (MALO_delay * .75);

};

if (MALO_delay < MALO_min_delay) then {

	MALO_delay = MALO_min_delay;

};

if (MALO_delay > MALO_max_delay) then {

	MALO_delay = MALO_max_delay;

};