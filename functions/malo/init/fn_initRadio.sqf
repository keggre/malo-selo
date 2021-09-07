// DEFINES THE VARIABLES USED IN THE KLPQ MUSIC RADIO MOD

if (false) exitWith {};

klpq_musicRadio_enable = true;
klpq_musicRadio_enableBackpackRadioMP = false;
klpq_musicRadio_radioThemes = ["serb"];

/*if (isServer) then {
	[] spawn {
		waitUntil {!MALO_init};
		{
			private _vehicle = _x:
			if (typeOf _vehicle in MALO_serb_vehicles) then {
				_vehicle setVariable ["klpq_musicradio_radioison", true, true];
			};
		} forEach vehicles;
	};
};*/