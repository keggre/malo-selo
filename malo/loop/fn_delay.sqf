if (!hasInterface) exitWith {};

if (diag_fps < MALO_CFG_target_framerate) then {

	MALO_delay = (MALO_delay + .05);

else {

	MALO_delay = (MALO_delay - .05);

};

if (MALO_delay < MALO_min_delay) then {

	MALO_delay = MALO_min_delay;

};

if (MALO_delay > MALO_max_delay) then {

	MALO_delay = MALO_max_delay;

};