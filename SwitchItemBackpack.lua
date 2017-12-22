-- Version: [0.3] - 22-12-2017

local SwitchItemBackpack = {}

SwitchItemBackpack.Enable = Menu.AddOption({ "Utility", "One Key Item to Backpack" }, "Enable", "Enable the script!")
SwitchItemBackpack.optionKey = Menu.AddKeyOption({"Utility", "One Key Item to Backpack"}, "Key for activate", Enum.ButtonCode.KEY_D)

SwitchItemBackpack.itemList = {
	item_branches = true,
	item_gauntlets = true,
	item_mantle = true,
	item_circlet = true,
	item_belt_of_strength = true,
	item_robe = true,
	item_ogre_axe = true,
	item_staff_of_wizardry = true,
	
	item_ghost = true,
	
	item_energy_booster = true,
	item_vitality_booster = true,
	item_point_booster = true,
	item_ultimate_orb = true,
	item_mystic_staff = true,
	item_reaver = true,
	
	item_magic_wand = true,
	item_null_talisman = true,
	item_wraith_band = true,
	item_bracer = true,
	item_oblivion_staff = true,
	
	item_headdress = true,
	item_buckler = true,
	item_urn_of_shadows = true,
	item_ring_of_aquila = true,
	item_arcane_boots = true,
	item_ancient_janggo = true,
	item_mekansm = true,
	item_vladmir = true,
	item_guardian_greaves = true,
	
	item_force_staff = true,
	item_veil_of_discord = true,
	item_aether_lens = true,
	item_necronomicon = true,
	item_necronomicon_2 = true,
	item_necronomicon_3 = true,
	item_dagon = true,
	item_dagon_2 = true,
	item_dagon_3 = true,
	item_dagon_4 = true,
	item_dagon_5 = true,
	item_cyclone = true,
	item_rod_of_atos = true,
	item_orchid = true,
	item_ultimate_scepter = true,
	item_sheepstick = true,
	item_octarine_core = true,
	
	item_vanguard = true,
	item_blade_mail = true,
	item_soul_booster = true,
	item_crimson_guard = true,
	item_black_king_bar = true,
	item_lotus_orb = true, 
	item_shivas_guard = true,
	item_manta = true,
	item_sphere = true,
	item_hurricane_pike = true,
	item_heart = true,
	
	item_basher = true,
	item_ethereal_blade = true,
	item_silver_edge = true,
	item_abyssal_blade = true,
	item_bloodthorn = true,
	
	item_helm_of_the_dominator = true,
	item_dragon_lance = true,
	item_sange = true,
	item_echo_sabre = true,
	item_diffusal_blade = true,
	item_diffusal_blade_2 = true,
	item_heavens_halberd = true,
	item_sange_and_yasha = true,
	item_skadi = true,
	item_satanic = true,

	item_kaya = true,
	item_meteor_hammer = true,
	item_aeon_disk = true,
	item_spirit_vessel, true
}
SwitchItemBackpack.sleepers = {}

function SwitchItemBackpack.OnUpdate()
	if not Menu.IsEnabled(SwitchItemBackpack.Enable) then
		return
	end

	local myHero = Heroes.GetLocal()

	if not myHero then
		return
	end
	
	if Menu.IsKeyDown(SwitchItemBackpack.optionKey) then
		SwitchItemBackpack.backpackItem(myHero, 0)
		SwitchItemBackpack.backpackItem(myHero, 1)
		SwitchItemBackpack.backpackItem(myHero, 2)
		SwitchItemBackpack.backpackItem(myHero, 3)
		SwitchItemBackpack.backpackItem(myHero, 4)		
		SwitchItemBackpack.backpackItem(myHero, 5)
	end
end

function SwitchItemBackpack.backpackItem(heroEnt, idxItem)
    local itemEnt = NPC.GetItemByIndex(heroEnt, idxItem)
	if  itemEnt ~= nil and Entity.IsAbility(itemEnt) then 
		local itemName = Ability.GetName(itemEnt)
				
		if 	SwitchItemBackpack.itemList[itemName] and SwitchItemBackpack.SleepCheck(1, "backpack" .. idxItem) then
			SwitchItemBackpack.MoveItemToSlot(heroEnt, itemEnt, math.random (6, 8))
			SwitchItemBackpack.MoveItemToSlot(heroEnt, itemEnt, idxItem)
			SwitchItemBackpack.Sleep(1, "backpack" .. idxItem)
			return
		end 
	end 
end

function SwitchItemBackpack.MoveItemToSlot(unit, item, slot)
    Player.PrepareUnitOrders(Players.GetLocal(), Enum.UnitOrder.DOTA_UNIT_ORDER_MOVE_ITEM, slot, Vector(0, 0, 0), item, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_PASSED_UNIT_ONLY, unit)
end

function SwitchItemBackpack.SleepCheck(delay, id)
	if not SwitchItemBackpack.sleepers[id] or (os.clock() - SwitchItemBackpack.sleepers[id]) > delay then
		return true
	end
	return false
end

function SwitchItemBackpack.Sleep(delay, id)
	if not SwitchItemBackpack.sleepers[id] or SwitchItemBackpack.sleepers[id] < os.clock() + delay then
		SwitchItemBackpack.sleepers[id] = os.clock() + delay
	end
end

return SwitchItemBackpack