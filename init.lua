ModLuaFileAppend("data/scripts/perks/perk_list.lua", "mods/Twin-Linked/files/scripts/perks.lua")

dofile_once( "data/scripts/perks/perk.lua" )
dofile_once( "data/scripts/perks/perk_list.lua" )
dofile_once( "data/scripts/lib/utilities.lua" )

function perker( hooman, perk_id )
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

function OnPlayerSpawned( player )
	--Flags
	local initer = "AKIMBO_BABY"
	if GameHasFlagRun( initer ) then
		return
	end
	GameAddFlagRun( initer )

	--check friendly fire issues on bloodlust and such
	--see the battle sister
	
	--Attach
	perker( player, "GOING_DUAL" )
	
	local x, y = EntityGetTransform( player )
	local gun_path = "data/entities/items/starting_wand_rng.xml"
	if( ModIsEnabled( "gura" )) then
		gun_path = "mods/gura/files/gura.xml"
	end
	EntityLoad( gun_path, x, y )
end
