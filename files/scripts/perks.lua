table.insert( perk_list,
{
	id = "GOING_DUAL",
	ui_name = "Twin-Linked",
	ui_description = "The Left obeys...",
	ui_icon = "mods/Twin-Linked/files/pics/perk_icon.png",
	perk_icon = "mods/Twin-Linked/files/pics/perk_icon.png",
	usable_by_enemies = false,
	not_in_default_perk_pool = true,
	func = function( entity_perk_item, entity_who_picked, item_name )
		EntityAddComponent( entity_who_picked, "HotspotComponent", {
			_tags = "left_arm_root", sprite_hotspot_name = "left_arm_start" })
		
		local x, y = EntityGetTransform( entity_who_picked )
		local left_arm = EntityLoad( "mods/Twin-Linked/files/entities/left_arm.xml", x, y )
		EntityAddChild( entity_who_picked, left_arm )

		local init_item = EntityLoad( "mods/Twin-Linked/files/entities/init_item.xml", x, y )
		local init_comp = EntityGetFirstComponentIncludingDisabled( init_item, "ItemComponent" )
		ComponentSetValue2( EntityGetFirstComponentIncludingDisabled( left_arm, "ItemPickUpperComponent" ), "only_pick_this_entity", init_item )
		ComponentSetValue2( init_comp, "npc_next_frame_pickable", 0 )
	end,
})