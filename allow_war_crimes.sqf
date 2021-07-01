if (!isDedicated) then {
while {true} do {
	sleep 1;
	if ((rating player < 0)) then {player addRating abs (rating player)};
};
};