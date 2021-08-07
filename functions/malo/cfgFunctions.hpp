class malo
{
	class main
	{
		file = "malo";
		class main {};

	};

	class ambient
	{
		file = "functions\malo\ambient"
		class ambientAnimals {};
		class ambientArty {};
		class ambientFire {};
		class ambientGunfire {};
		class ambientAircraft {};
	};

	class cutscenes
	{
		file = "functions\malo\cutscenes"
		class cutsceneAmbush {};
		class cutsceneMortar {};
		class cutsceneOpening {};
	};

	class init
	{
		file = "functions\malo\init"
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
		file = "functions\malo\loop"
		class ambient {};
		class civs {};
		class combat {};
		class debug {};
		class delay {};
		class deleteTasks {};
		class dynamicSimulation {};
		class internationalOpinion {};
		class missions {};
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
		file = "functions\malo\misc"
		class activateTrigger {};
		class addSupport {};
		class append {};
		class callFunctions {};
		class callSupport {};
		class capsquads {};
		class captureVillage {};
		class getUnitsWithinRadius {};
		class deleteObjects {};
		class deleteUnCheckpoints {};
		class createRespawn {};
		class damageWithinRadius {};
		class disableTrigger {};
		class getNearestPlayer {};
		class isArmed {};
		class killWithinRadius {};
		// class loadGroups {};
		class loadVillage {};
		class noPlayersNearby {};
		// class saveGroups {};
		class setViewDistance {};
	};

	class missions
	{
		file = "functions\malo\missions"
		class chernogorsk {};
		class missionShootout {};
		class missionSmugglerTrucks {};
		class missionPoi1 {};
		class missionPoi2 {};
		class missionPoi3 {};
		class missionPoi4 {};
		class missionPoi5 {};
		class missionPoi6 {};
		class missionPoi7 {};
		class missionPoi8 {};
		class missionPoi9 {};
	};

	class save 
	{
		file = "functions\malo\save"
		class load {};
		class loadProgress {};
		class loadKeywords {};
		class save {};
		class saveKeyword {};
	};
};
