// ADDS CONFIGURATION OPTIONS FOR THE MISSION IN THE PAUSE MENU

if (!hasInterface) exitWith {};

MALO_simulation_distance = MALO_CFG_min_simulation_distance;

[
	"MALO_CFG_target_framerate", 
	"SLIDER", 
	["Target FPS", "Increases or decreases simulation distance and view distance to target a framerate. Set to 0 to disable."], 
	"Malo Selo", 
	[0, 60, MALO_CFG_target_framerate, 0], 
	0, 
	{}, 
	false
] call cba_fnc_addSetting;

[
	"MALO_CFG_min_simulation_distance", 
	"SLIDER", 
	["Minimum simulation distance", "Minimum radius in which ai units are simulated. Lower to improve game performance."], 
	"Malo Selo", 
	[100, 10000, MALO_CFG_min_simulation_distance, 0], 
	1, 
	{}, 
	false
] call cba_fnc_addSetting;

[
	"MALO_CFG_max_simulation_distance", 
	"SLIDER", 
	["Maximum simulation distance", "Maximum radius in which ai units are simulated. Lower to improve game performance."], 
	"Malo Selo", 
	[100, 10000, MALO_CFG_max_simulation_distance, 0], 
	1, 
	{}, 
	false
] call cba_fnc_addSetting;

[
	"MALO_CFG_view_distance", 
	"SLIDER", 
	["View distance", "Default view distance. Can be overwritten if dynamic view distance is on."], 
	"Malo Selo", 
	[100, 10000, MALO_CFG_view_distance, 0], 
	0, 
	{}, 
	false
] call cba_fnc_addSetting;

[
	"MALO_CFG_dynamic_view_distance", 
	"CHECKBOX", 
	["Enable dynamic view distance", "Dynamic view distance allows the view distance to be reduced or raised automatically where necessary."], 
	"Malo Selo", 
	MALO_CFG_dynamic_view_distance, 
	0, 
	{}, 
	false
] call cba_fnc_addSetting;

[
	"MALO_CFG_dynamic_view_distance_min", 
	"SLIDER", 
	["Minimum view distance", "Minimum view distance possible when dynamic view distance is enabled."], 
	"Malo Selo", 
	[100, 10000, MALO_CFG_dynamic_view_distance_min, 0], 
	0, 
	{}, 
	false
] call cba_fnc_addSetting;

[
	"MALO_CFG_dynamic_view_distance_max", 
	"SLIDER", 
	["Maximum view distance", "Maximum view distance possible when dynamic view distance is enabled."], 
	"Malo Selo", 
	[100, 10000, MALO_CFG_dynamic_view_distance_max, 0], 
	0, 
	{}, 
	false
] call cba_fnc_addSetting;

[
	"MALO_CFG_dynamic_view_distance_altitude_multiplier", 
	"SLIDER", 
	["View distance altitude multiplier", "Constant that determines how much altitude affects view distance in dynamic view distance mode."], 
	"Malo Selo", 
	[1, 100, MALO_CFG_dynamic_view_distance_altitude_multiplier, 0], 
	0, 
	{}, 
	false
] call cba_fnc_addSetting;

[
	"MALO_CFG_dynamic_view_distance_smoothing", 
	"SLIDER", 
	["View distance smoothing", "Constant that determines the smoothness of transitions between different view distances."], 
	"Malo Selo", 
	[1, 100, MALO_CFG_dynamic_view_distance_smoothing, 0], 
	0, 
	{}, 
	false
] call cba_fnc_addSetting;

[
	"MALO_CFG_night_brightness", 
	"SLIDER", 
	["Night brightness", "Intensity of nighttime ambient light."], 
	"Malo Selo", 
	[0, 100, MALO_CFG_night_brightness, 0], 
	1, 
	{}, 
	false
] call cba_fnc_addSetting;

[
	"MALO_CFG_time_multiplier", 
	"SLIDER", 
	["Time multiplier", "How fast time passes in-game as opposed to real life."], 
	"Malo Selo", 
	[1, 24, MALO_CFG_time_multiplier, 0], 
	1, 
	{}, 
	false
] call cba_fnc_addSetting;

[
	"MALO_CFG_enable_cutscenes", 
	"CHECKBOX", 
	["Enable cutscenes", "Enables or disables cutscenes."], 
	"Malo Selo", 
	MALO_CFG_enable_cutscenes, 
	0, 
	{}, 
	false
] call cba_fnc_addSetting;

[
	"MALO_CFG_use_simple_objects", 
	"CHECKBOX", 
	["Use simple objects", "Enable to improve performance, but only when absolutely needed."], 
	"Malo Selo", 
	MALO_CFG_use_simple_objects, 
	1, 
	{}, 
	true
] call cba_fnc_addSetting;

[
	"MALO_CFG_ambient_animals", 
	"CHECKBOX", 
	["Enable ambient animals", "Enables or disables ambient animals. Disable to improve performance."], 
	"Malo Selo", 
	MALO_CFG_ambient_animals, 
	1, 
	{}, 
	false
] call cba_fnc_addSetting;

[
	"MALO_CFG_ambient_arty", 
	"CHECKBOX", 
	["Enable ambient artillery", "Enables or disables ambient artillery. Disable to improve performance."], 
	"Malo Selo", 
	MALO_CFG_ambient_arty, 
	1, 
	{}, 
	false
] call cba_fnc_addSetting;

[
	"MALO_CFG_ambient_fire", 
	"CHECKBOX", 
	["Enable ambient fire", "Enables or disables ambient fire. Disable to improve performance."], 
	"Malo Selo", 
	MALO_CFG_ambient_fire, 
	1, 
	{}, 
	false
] call cba_fnc_addSetting;

[
	"MALO_CFG_ambient_gunfire", 
	"CHECKBOX", 
	["Enable ambient gunfire", "Enables or disables ambient gunfire. Disable to improve performance."], 
	"Malo Selo", 
	MALO_CFG_ambient_gunfire, 
	1, 
	{}, 
	false
] call cba_fnc_addSetting;

[
	"MALO_CFG_ambient_plane", 
	"CHECKBOX", 
	["Enable ambient aircraft", "Enables or disables ambient aircraft. Disable to improve performance."], 
	"Malo Selo", 
	MALO_CFG_ambient_plane, 
	1, 
	{}, 
	false
] call cba_fnc_addSetting;

[
	"MALO_CFG_allow_war_crimes", 
	"CHECKBOX", 
	["Allow war crimes", "When enabled, players will not be executed by friendly ai units for killing teammates or civilians."], 
	"Malo Selo", 
	MALO_CFG_allow_war_crimes, 
	1, 
	{}, 
	false
] call cba_fnc_addSetting;

[
	"MALO_CFG_saving", 
	"CHECKBOX", 
	["Enable saving", "Allows mission progress to be saved locally to the user profile."], 
	"Malo Selo", 
	MALO_CFG_saving, 
	0, 
	{}, 
	false
] call cba_fnc_addSetting;

[
	"MALO_CFG_loading", 
	"CHECKBOX", 
	["Load save file", "When enabled, the save file from the user profile will be loaded at mission start if it exists."], 
	"Malo Selo", 
	MALO_CFG_loading, 
	1, 
	{}, 
	true
] call cba_fnc_addSetting;

[
	"MALO_CFG_overwrite", 
	"CHECKBOX", 
	["Allow overwrite", "When enabled, previous saves will be overwritten when mission progress is saved."], 
	"Malo Selo", 
	MALO_CFG_overwrite, 
	0, 
	{}, 
	false
] call cba_fnc_addSetting;