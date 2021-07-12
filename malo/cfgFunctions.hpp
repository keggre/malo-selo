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
		class initAnimals {};
		class initCivs {};
		class initFlee {};
		class initSliders {};
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
		class debug {};
		class delay {};
		class deleteTasks {};
		class dynamicSimulation {};
		class flee {};
		class playerSquadSimulation {};
		class reload {};
		class simulationDistance {};
		class supplyTruck {};
		class viewDistance {};
		class villages {};
		class weather {};
	};

	class misc
	{
		file = "malo\misc"
		class activateTrigger {};
		class capsquads {};
		class captureVillage {};
		class createRespawn {};
		class damageWithinRadius {};
		class disableTrigger {};
		class killWithinRadius {};
		class setViewDistance {};
		class smugglerTrucks {};
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
