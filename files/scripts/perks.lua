table.insert(perk_list,
{
	id = "GOING_DUAL",
	ui_name = "Twin-Linked",
	ui_description = "Spirits of the Left Hand are now obey you.",
	ui_icon = "mods/Twin-Linked/files/pics/perk_icon.png",
	perk_icon = "mods/Twin-Linked/files/pics/perk_icon.png",
	usable_by_enemies = false,
	not_in_default_perk_pool = true,
	func = function( entity_perk_item, entity_who_picked, item_name )
		edit_component_with_tag( entity_who_picked, "SpriteComponent", "character", function(comp,vars) 
			ComponentSetValue2( comp, "image_file", "mods/Twin-Linked/files/pics/player_handless.xml" )
			EntityRefreshSprite( entity_who_picked, comp )
		end)
		
		local hot_comp = EntityAddComponent( entity_who_picked, "HotspotComponent",
		{
			_tags = "left_arm_root",
			sprite_hotspot_name = "left_arm_start",
		})
		
		local x, y = EntityGetTransform( entity_who_picked )
		local left_arm = EntityLoad( "mods/Twin-Linked/files/entities/left_arm.xml", x, y )
		EntityAddChild( entity_who_picked, left_arm )
	end,
})