class malo
{
	class main
	{
		file = "malo";
		class main {};

	};

	class ambient
	{
		file = "malo\ambient"
		class ambientAnimals {};
		class ambientArty {};
		class ambientFire {};
		class ambientGunfire {};
		class ambientPlane {};
	};

	class cutscenes
	{
		file = "malo\cutscenes"
		class cutsceneAmbush {};
		class cutsceneMortar {};
		class cutsceneOpening {};
	};

	class init
	{
		file = "malo\init"
		class initBuildings {};
		class initCivs {};
		class initLoadouts {};
		class initOptions {};
		class initRadio {};
		class initSimulation {};
		class initVillages {};
		class initTasks {};
		class initPois {};
	};

	class loop
	{
		file = "malo\loop"
		class allowWarCrimes {};
		class ambient {};
		class civs {};
		class combat {};
		class debug {};
		class delay {};
		class deleteTasks {};
		class dynamicSimulation {};
		class player {};
		class reload {};
		class simulationDistance {};
		class stealth;
		class taskDestinations {};
		class tips {};
		class viewDistance {};
		class villages {};
		class weather {};
	};

	class misc
	{
		file = "malo\misc"
		class activateTrigger {};
		class callFunctions {};
		class capsquads {};
		class captureVillage {};
		class getUnitsWithinRadius {};
		class createRespawn {};
		class damageWithinRadius {};
		class disableTrigger {};
		class getClosestPlayer {};
		class isArmed {};
		class killWithinRadius {};
		class setViewDistance {};
	};

	class missions
	{
		file = "malo\missions"
		class mission_Shootout {};
		class mission_SmugglerTrucks {};
	};

	class save 
	{
		file = "malo\save"
		class load {};
		class loadProgress {};
		class loadProgressKeywords {};
		class save {};
		class savePush {};
	};
};
