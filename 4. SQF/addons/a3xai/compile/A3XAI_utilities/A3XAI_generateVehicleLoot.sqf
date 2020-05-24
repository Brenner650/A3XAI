#include "\A3XAI\globaldefines.hpp"

private ["_vehicle", "_unitLevel", "_weapon", "_magazine", "_lootItem"];

_vehicle = _this;

if (isNull _vehicle) exitWith {};

_unitLevel = A3XAI_unitLevels call A3XAI_selectRandom;

for "_i" from 1 to A3XAI_weaponLootVehicleCount do {
	_weapon = _unitLevel call A3XAI_getWeapon;
	_magazine = getArray (configFile >> "CfgWeapons" >> _weapon >> "magazines") select 0;
	_vehicle addWeaponCargoGlobal [_weapon,1];
	_vehicle addMagazineCargoGlobal [_magazine,A3XAI_ammoLootPerWeapon];
};

for "_i" from 1 to A3XAI_foodLootVehicleCount do {
	_lootItem = (A3XAI_foodLoot call A3XAI_selectRandom);
	_vehicle addItemCargoGlobal [_lootItem,1];
};

for "_i" from 1 to A3XAI_miscLootVehicleCount do {
	_lootItem = (A3XAI_miscLoot call A3XAI_selectRandom);
	_vehicle addItemCargoGlobal [_lootItem,1];
};

for "_i" from 1 to A3XAI_medicalLootVehicleCount do {
	_lootItem = (A3XAI_medicalLoot call A3XAI_selectRandom);
	_vehicle addItemCargoGlobal [_lootItem,1];
};

if (A3XAI_debugLevel > 1) then {
	diag_log format ["A3XAI Debug: Generated loot for AI %1 at %2 with unitLevel %3.",(typeOf _vehicle),(getPosATL _vehicle),_unitLevel];
};

true