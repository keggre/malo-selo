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
		class ambientPlane {};
	};

	class init
	{
		file = "malo\init"
		class initCivs {};
		class initFlee {};
		class initSliders {};
		class initRadio {};
		class initVillages {};
		class initPois {};
	};

	class loop
	{
		file = "malo\loop"
		class allowWarCrimes {};
		class debug {};
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
	}
};
