-- Version: [0.1] - 08-10-2017

local SwitchItemBackpack = {}

SwitchItemBackpack.Enable = Menu.AddOption({ "Utility", "One Key Item to Backpack" }, "Enable", "Enable the script!")
SwitchItemBackpack.optionKey = Menu.AddKeyOption({"Utility", "One Key Item to Backpack"}, "Key for activate", Enum.ButtonCode.KEY_D)

SwitchItemBackpack.itemList = {
	item_ward_dispenser = true,
	item_tango_single = true,
	
	item_clarity = true,
	item_faerie_fire = true,
	item_enchanted_mango = true,
	item_tango = true,
	item_flask = true,
	item_smoke_of_deceit = true,
	item_tpscroll = true,
	item_dust = true,
	item_courier = true,
	item_flying_courier = true,
	item_ward_observer = true,
	item_ward_sentry = true,
	item_tome_of_knowledge = true,
	item_bottle = true,
	
	item_slippers = true,
	item_boots_of_elves = true,
	item_blade_of_alacrity = true,
	
	item_ring_of_protection = true,
	item_stout_shield = true,
	item_quelling_blade = true,
	item_infused_raindrop = true,
	item_blight_stone = true,
	item_orb_of_venom = true,
	item_blades_of_attack = true,
	item_chainmail = true,
	item_quarterstaff = true,
	item_helm_of_iron_will = true,
	item_broadsword = true,
	item_claymore = true,
	item_javelin = true,
	item_mithril_hammer = true,
	
	item_wind_lace = true,
	item_magic_stick = true,
	item_sobi_mask = true,
	item_ring_of_regen = true,
	item_boots = true,
	item_gloves = true,
	item_cloak = true,
	item_ring_of_health = true,
	item_void_stone = true,
	item_gem = true,
	item_lifesteal = true,
	item_shadow_amulet = true,
	item_ghost = true,
	item_blink = true,
	
	item_platemail = true,
	item_talisman_of_evasion = true,
	item_hyperstone = true,
	item_demon_edge = true,
	item_eagle = true,
	item_relic = true,
	
	item_poor_mans_shield = true,
	item_soul_ring = true,
	item_phase_boots = true,
	item_pers = true,
	item_hand_of_midas = true,
	item_travel_boots = true,
	item_moon_shard = true,
	
	item_ring_of_basilius = true,
	item_iron_talon = true,
	item_tranquil_boots = true,
	item_medallion_of_courage = true,
	item_pipe = true,
	
	item_glimmer_cape = true,
	item_solar_crest = true,
	
	item_hood_of_defiance = true,
	item_assault = true,
	
	item_lesser_crit = true,
	item_armlet = true,
	item_invis_sword = true,
	item_bfury = true,
	item_radiance = true,
	item_monkey_king_bar = true,
	item_butterfly = true,
	item_rapier = true,
	
	item_mask_of_madness = true,
	item_yasha = true,
	item_maelstrom = true,
	item_desolator = true,
	item_mjollnir = true
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
				
		if not SwitchItemBackpack.itemList[itemName] and SwitchItemBackpack.SleepCheck(1, "backpack" .. idxItem) then
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