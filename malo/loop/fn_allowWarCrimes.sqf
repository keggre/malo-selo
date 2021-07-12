// PREVENTS PLAYERS FROM BEING KILLED BY FRIENDLY AI BECAUSE OF TEAMKILLING OR CIVILIAN KILLS

if (!hasInterface) exitWith {};
if (MALO_CFG_allow_war_crimes == false) exitWith {};

if ((rating player < 0)) then {
	
	player addRating abs (rating player)
	
};