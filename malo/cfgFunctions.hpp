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
	};

	class init
	{
		file = "malo\init"
		class initCivs {};
		class initFlee {};
		class initSliders {};
		class initVillages {};
	};

	class loop
	{
		file = "malo\loop"
		class allowWarCrimes {};
		class flee {};
		class playerSquadSimulation {};
		class radio {};
		class reload {};
		class viewDistance {};
		class villages {};
	};

	class misc
	{
		file = "malo\misc"
		class capsquads {};
		class captureVillage {};
		class setViewDistance {};
	};

	class missions
	{
		file = "malo\missions"
		class smugglerTrucks {};
	};

	class save 
	{
		file = "malo\save"
		class load {};
		class save {};
	}
};
