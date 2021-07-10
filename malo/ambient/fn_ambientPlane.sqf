if (!isServer) exitWith {};

if (MALO_CFG_ambient_plane == true) then {

	ambient_plane_1 enableSimulationGlobal true;
	ambient_plane_1D enableSimulationGlobal true;

} then {

	ambient_plane_1 enableSimulationGlobal false;
	ambient_plane_1D enableSimulationGlobal false;

};