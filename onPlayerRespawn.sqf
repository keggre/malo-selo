if (!hasInterface) exitWith {};

[player, [profileNamespace, "MALO_saved_inventory"]] call BIS_fnc_loadInventory;

// REMOVE WEAPONS
removeAllWeapons player;

// REMOVE OTHER NON-PERSISTENT ITEMS
player removeItems "FirstAidKit";

// ADD ITEMS
player addItem "murshun_cigs_lighter";