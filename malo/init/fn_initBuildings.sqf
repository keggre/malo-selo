// BUILDING TYPES EXISTING ON THE MAP

if (!isServer) exitWith {};

MALO_building_types = ["Land_A_BuildingWIP","Land_A_FuelStation_Build","Land_A_GeneralStore_01","Land_A_GeneralStore_01a","Land_A_Hospital","Land_A_Pub_01","Land_a_stationhouse","Land_Barn_Metal","Land_Barn_W_01","Land_Church_03","Land_Farm_Cowshed_a","Land_Farm_Cowshed_b","Land_Farm_Cowshed_c","Land_Hlidac_budka","Land_HouseBlock_A1","Land_HouseB_Tenement","Land_HouseV2_01A","Land_HouseV2_02_Interier","Land_HouseV2_04_interier","Land_HouseV_1I1","Land_HouseV_1I4","Land_HouseV_1L1","Land_HouseV_1L2","Land_HouseV_2L","Land_Ind_Garage01","Land_Ind_Workshop01_01","Land_Ind_Workshop01_02","Land_Ind_Workshop01_04","Land_Ind_Workshop01_L","Land_kulna","Land_Mil_Barracks_i","Land_Mil_ControlTower","Land_Panelak","Land_Panelak2","Land_Rail_House_01","Land_rail_station_big","Land_Shed_Ind02","Land_Shed_W01","Land_stodola_old_open","Land_Tovarna2","Land_vez","Land_CarService_F","Land_Chapel_Small_V1_F","Land_Chapel_Small_V2_F","Land_Chapel_V1_F","Land_Chapel_V2_F","Land_d_Stone_Shed_V1_F","Land_FuelStation_Build_F","Land_FuelStation_Shed_F","Land_Hospital_main_F","Land_Hospital_side1_F","Land_Hospital_side2_F","Land_i_Addon_02_V1_F","Land_i_Addon_03mid_V1_F","Land_i_Addon_03_V1_F","Land_i_Addon_04_V1_F","Land_i_Barracks_V1_F","Land_i_Barracks_V2_F","Land_i_Garage_V1_F","Land_i_Garage_V2_F","Land_i_House_Big_01_V1_F","Land_i_House_Big_01_V2_F","Land_i_House_Big_01_V3_F","Land_i_House_Big_02_V1_F","Land_i_House_Big_02_V2_F","Land_i_House_Big_02_V3_F","Land_i_House_Small_01_V1_F","Land_i_House_Small_01_V2_F","Land_i_House_Small_01_V3_F","Land_i_House_Small_02_V1_F","Land_i_House_Small_02_V2_F","Land_i_House_Small_02_V3_F","Land_i_House_Small_03_V1_F","Land_i_Shed_Ind_F","Land_i_Shop_01_V1_F","Land_i_Shop_01_V2_F","Land_i_Shop_01_V3_F","Land_i_Shop_02_V1_F","Land_i_Shop_02_V2_F","Land_i_Shop_02_V3_F","Land_i_Stone_HouseBig_V1_F","Land_i_Stone_HouseBig_V2_F","Land_i_Stone_HouseBig_V3_F","Land_i_Stone_HouseSmall_V1_F","Land_i_Stone_HouseSmall_V2_F","Land_i_Stone_HouseSmall_V3_F","Land_i_Stone_Shed_V1_F","Land_i_Stone_Shed_V2_F","Land_i_Stone_Shed_V3_F","Land_Metal_Shed_F","Land_MilOffices_V1_F","Land_Offices_01_V1_F","Land_Slum_House01_F","Land_Slum_House02_F","Land_Slum_House03_F","Land_Unfinished_Building_01_F","Land_Unfinished_Building_02_F","Land_u_Addon_01_V1_F","Land_u_Addon_02_V1_F","Land_u_Barracks_V2_F","Land_u_House_Big_01_V1_F","Land_u_House_Big_02_V1_F","Land_u_House_Small_01_V1_F","Land_u_House_Small_02_V1_F","Land_u_Shed_Ind_F","Land_u_Shop_01_V1_F","Land_u_Shop_02_V1_F","Land_WIP_F"]; 
publicVariable "MALO_buildingTypes";