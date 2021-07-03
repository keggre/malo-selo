[
	"MALO_view_distance", 
	"SLIDER", 
	["View distance", "Default view distance. Can be overwritten if dynamic view distance is on."], 
	"Malo Selo", 
	[1, 10000, MALO_view_distance, 0], 
	0, 
	{}, 
	false
] call cba_fnc_addSetting;

[
	"MALO_dynamic_view_distance", 
	"CHECKBOX", 
	["Enable dynamic view distance", "Dynamic view distance allows the view distance to be reduced or raised automatically where necessary."], 
	"Malo Selo", 
	MALO_dynamic_view_distance, 
	0, 
	{}, 
	false
] call cba_fnc_addSetting;

[
	"MALO_dynamic_view_distance_min", 
	"SLIDER", 
	["Minimum view distance", "Minimum view distance possible when dynamic view distance is enabled."], 
	"Malo Selo", 
	[1, 10000, MALO_dynamic_view_distance_min, 0], 
	0, 
	{}, 
	false
] call cba_fnc_addSetting;

[
	"MALO_dynamic_view_distance_max", 
	"SLIDER", 
	["Maximum view distance", "Maximum view distance possible when dynamic view distance is enabled."], 
	"Malo Selo", 
	[1, 10000, MALO_dynamic_view_distance_max, 0], 
	0, 
	{}, 
	false
] call cba_fnc_addSetting;

[
	"MALO_dynamic_view_distance_altitude_multiplier", 
	"SLIDER", 
	["View distance altitude multiplier", "Constant that determines how much altitude affects view distance in dynamic view distance mode."], 
	"Malo Selo", 
	[1, 100, MALO_dynamic_view_distance_altitude_multiplier, 0], 
	0, 
	{}, 
	false
] call cba_fnc_addSetting;

[
	"MALO_dynamic_view_distance_smoothing", 
	"SLIDER", 
	["View distance smoothing", "Constant that determines the smoothness of transitions between different view distances."], 
	"Malo Selo", 
	[1, 500, MALO_dynamic_view_distance_smoothing, 0], 
	0, 
	{}, 
	false
] call cba_fnc_addSetting;

[
	"MALO_night_brightness", 
	"SLIDER", 
	["Night brightness", "Intensity of nighttime ambient light."], 
	"Malo Selo", 
	[0, 100, MALO_night_brightness, 0], 
	1, 
	{}, 
	false
] call cba_fnc_addSetting;

[
	"MALO_time_multiplier", 
	"SLIDER", 
	["Time multiplier", "How fast time passes in-game as opposed to real life."], 
	"Malo Selo", 
	[1, 24, MALO_time_multiplier, 0], 
	1, 
	{}, 
	false
] call cba_fnc_addSetting;

[
	"MALO_enable_cutscenes", 
	"CHECKBOX", 
	["Enable cutscenes", "Enables or disables cutscenes."], 
	"Malo Selo", 
	MALO_enable_cutscenes, 
	0, 
	{}, 
	false
] call cba_fnc_addSetting;

[
	"MALO_ambient_plane", 
	"CHECKBOX", 
	["Enable ambient aircraft", "Enables or disables ambient aircraft. Only works on mission restart."], 
	"Malo Selo", 
	MALO_ambient_plane, 
	1, 
	{}, 
	true
] call cba_fnc_addSetting;

[
	"MALO_ambient_fire", 
	"CHECKBOX", 
	["Enable ambient gunfire", "Enables or disables ambient gunfire. Only works on mission restart."], 
	"Malo Selo", 
	MALO_ambient_fire, 
	1, 
	{}, 
	true
] call cba_fnc_addSetting;

[
	"MALO_allow_war_crimes", 
	"CHECKBOX", 
	["Allow war crimes", "When enabled, players will not be executed by friendly ai units for killing teammates or civilians."], 
	"Malo Selo", 
	MALO_allow_war_crimes, 
	1, 
	{}, 
	false
] call cba_fnc_addSetting;

[
	"MALO_saving", 
	"CHECKBOX", 
	["Enable saving", "Allows mission progress to be saved locally to the user profile."], 
	"Malo Selo", 
	MALO_saving, 
	0, 
	{}, 
	false
] call cba_fnc_addSetting;

[
	"MALO_loading", 
	"CHECKBOX", 
	["Load save file", "When enabled, the save file from the user profile will be loaded at mission start if it exists."], 
	"Malo Selo", 
	MALO_loading, 
	0, 
	{}, 
	true
] call cba_fnc_addSetting;