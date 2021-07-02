class skhpersist
{
	class save_eh
	{
		file = "save\eh";
		class CallFunctionFromFileOrCode {};
	};

	class save_main
	{
		file = "save\main";
		class InitializeSaveSystem {};
		class ListExistingVariables {};
		class ClearSave {};
		class LoadData {};
		class SaveData {};
		class LoadGame {};
		class SaveGame {};
	};
	
	class save_actions
	{
		file = "save\actions";
		class FindObjectsToAddActions {};
		class MarkForSave {};
		class UnmarkForSave {};
	};

	class save_log
	{
		file = "save\log";
		class LogToRPT {};
	};
	
	class save_specific
	{
		file = "save\specific";
		class AddCustomContainerToSave {};
		class AddCustomUnitToSave {};
		class AddCustomVariableToSave {};
		class AddCustomVehicleToSave {};
		class LoadCustomContainers {};
		class SaveCustomContainers {};
		class LoadCustomUnits {};
		class SaveCustomUnits {};
		class LoadCustomVariables {};
		class SaveCustomVariables {};
		class LoadCustomVehicles {};
		class SaveCustomVehicles {};
		class LoadEnvironmentInfo {};
		class SaveEnvironmentInfo {};
		class LoadMapMarkers {};
		class SaveMapMarkers {};
		class SaveMetadata {};
		class LoadPlayer {};
		class SavePlayer {};
	};
	
	class save_specific_common_cargo
	{
		file = "save\specific\common\cargo";
		class ApplyCargo {};
		class GenerateCargoArray {};
	};
	
	class save_specific_common_damage
	{
		file = "save\specific\common\damage";
		class ApplyDamages {};
	};

	class save_specific_common_namespaces
	{
		file = "save\specific\common\namespaces";
		class LoadVariableFromNamespace {};
		class SaveVariableToNamespace {};
	};
	
	class save_specific_common_position
	{
		file = "save\specific\common\position";
		class ApplyPositionAndRotation {};
		class GeneratePositionAndRotationArray {};
	};
	
	class save_specific_common_unit
	{
		file = "save\specific\common\unit";
		class GenerateGroupArray {};
		class GenerateUnitArray {};
		class LoadUnitData {};
	};

	class save_trigger
	{
		file = "save\trigger";
		class CreateRadioTrigger {};
	};

	class save_trigger_savesystem
	{
		file = "save\trigger\savesystem";
		class ClearLoadTriggers {};
		class CreateSaveTrigger {};
		class InitTriggerSaveSystem {};
		class SaveGameOnNextSlot {};
		class UpdateRadioTriggers {};
	};
	
	class save_utils_arrays
	{
		file = "save\utils\arrays";
		class GetByKey {};
	};
	
	class save_utils_date
	{
		file = "save\utils\date";
		class CompareDates {};
	};
}; 