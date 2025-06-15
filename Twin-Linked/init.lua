ModLuaFileAppend( "data/scripts/perks/perk_list.lua", "mods/Twin-Linked/files/scripts/perks.lua" )

function OnModInit()
	if( not( ModIsEnabled( "index_core" ))) then return end
	dofile_once( "mods/index_core/files/_lib.lua" )

	pen.magic_append( "mods/index_core/files/_structure.lua", "mods/Twin-Linked/files/scripts/wand_stats.lua" )
end

function OnPlayerSpawned( player )
	if( not( ModIsEnabled( "index_core" ))) then return end
	dofile_once( "mods/index_core/files/_lib.lua" )
	
	local initer = "AKIMBO_BABY"
	if GameHasFlagRun( initer ) then return end
	GameAddFlagRun( initer )

	local arm_file = "mods/Twin-Linked/files/entities/left_arm.xml"
	local file = pen.magic_read( arm_file )
	file = string.gsub( file, "%[%[ARM_SPOT%]%]", GlobalsGetValue( "TWIN_LINKED_ARM", "mods/Twin-Linked/files/pics/arm_left.xml" ))
	pen.magic_write( arm_file, file )

	pen.add_perk( player, "GOING_DUAL" )
end
