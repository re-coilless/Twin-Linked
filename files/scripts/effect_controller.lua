dofile_once( "mods/index_core/files/_lib.lua" )

local l_arm = GetUpdatedEntityID()
local hooman = EntityGetRootEntity( l_arm )

local rage_clock = GameGetGameEffectCount( hooman, "BERSERK" )
local rage_comp = GameGetGameEffect( l_arm, "BERSERK" )
if( rage_clock > 0 ) then
	if( rage_comp > 0 ) then
		ComponentSetValue2( rage_comp, "frames", 5 )
	else
		local comp_id, entity_id = GetGameEffectLoadTo( l_arm, "BERSERK", true )
		ComponentSetValue2( comp_id, "frames", 2 )
		
		local light_comp = EntityGetFirstComponentIncludingDisabled( entity_id, "LightComponent" )
		if( light_comp ~= nil ) then
			EntityRemoveComponent( entity_id, light_comp )
		end
		local emit_comp = EntityGetFirstComponentIncludingDisabled( entity_id, "SpriteParticleEmitterComponent" )
		if( emit_comp ~= nil ) then
			EntityRemoveComponent( entity_id, emit_comp )
		end
	end
elseif( GameGetGameEffectCount( l_arm, "BERSERK" ) > 0 ) then
	EntityRemoveComponent( l_arm, rage_comp )
end

local nuke_clock = GameGetGameEffectCount( hooman, "DAMAGE_MULTIPLIER" )
if( nuke_clock > 0 ) then
	ComponentSetValue2( GameGetGameEffect( hooman, "DAMAGE_MULTIPLIER" ), "frames", 0 )
	ComponentSetValue2( GetGameEffectLoadTo( get_hooman_child( l_arm, "arm_r" ), "DAMAGE_MULTIPLIER", true ), "frames", -1 )
end