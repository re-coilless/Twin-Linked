ModLuaFileAppend( "data/scripts/perks/perk_list.lua", "mods/Twin-Linked/files/scripts/perks.lua" )

--try making an easy-to-do compatibility system for others
function OnModInit()
	if( not( ModIsEnabled( "index_core" ))) then return end
	
	dofile_once( "mods/index_core/files/_lib.lua" )
	pen.magic_append( "mods/index_core/files/_structure.lua", "mods/Twin-Linked/files/scripts/wand_stats.lua" )
end

function OnPlayerSpawned( player )
	if( not( ModIsEnabled( "index_core" ))) then return end
	
	local initer = "AKIMBO_BABY"
	if GameHasFlagRun( initer ) then return end
	GameAddFlagRun( initer )

	function perker( hooman, perk_id )
		dofile_once( "data/scripts/lib/utilities.lua" )
		dofile_once( "data/scripts/perks/perk.lua" )
		dofile_once( "data/scripts/perks/perk_list.lua" )
	
		local perk_data = get_perk_with_id( perk_list, perk_id )
		local name = get_perk_picked_flag_name( perk_id )
		local name_persistent = string.lower( name )
		if( not( HasFlagPersistent( name_persistent ))) then
			GameAddFlagRun( "new_" .. name_persistent )
		end
		GameAddFlagRun( name )
		AddFlagPersistent( name_persistent )
		
		if perk_data.game_effect ~= nil then
			ComponentSetValue2( GetGameEffectLoadTo( hooman, perk_data.game_effect, true ), "frames", -1 )
		end
		if perk_data.func ~= nil then
			perk_data.func( nil, hooman, nil )
		end
		
		local ui = EntityCreateNew( "" )
		EntityAddComponent( ui, "UIIconComponent",
		{
			name = perk_data.ui_name,
			description = perk_data.ui_description,
			icon_sprite_file = perk_data.ui_icon
		})
		EntityAddChild( hooman, ui )
	end
	perker( player, "GOING_DUAL" )
end
