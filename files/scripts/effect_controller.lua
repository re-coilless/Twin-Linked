dofile_once( "mods/index_core/files/_lib.lua" )

local l_arm = GetUpdatedEntityID()
local hooman = EntityGetRootEntity( l_arm )

local rage_comp = GameGetGameEffect( l_arm, "BERSERK" )
local rage_clock = GameGetGameEffectCount( hooman, "BERSERK" )
if( pen.vld( rage_clock, true )) then
	if( not( pen.vld( rage_comp, true ))) then
		local comp_id, entity_id = GetGameEffectLoadTo( l_arm, "BERSERK", true )
		ComponentSetValue2( comp_id, "frames", 2 )
		
		local light_comp = EntityGetFirstComponentIncludingDisabled( entity_id, "LightComponent" )
		if( pen.vld( light_comp, true )) then EntityRemoveComponent( entity_id, light_comp ) end
		local emit_comp = EntityGetFirstComponentIncludingDisabled( entity_id, "SpriteParticleEmitterComponent" )
		if( pen.vld( emit_comp, true )) then EntityRemoveComponent( entity_id, emit_comp ) end
	else ComponentSetValue2( rage_comp, "frames", 5 ) end
elseif( pen.vld( GameGetGameEffectCount( l_arm, "BERSERK" ), true )) then EntityRemoveComponent( l_arm, rage_comp ) end

if( pen.vld( GameGetGameEffectCount( hooman, "DAMAGE_MULTIPLIER" ), true )) then
	ComponentSetValue2( GameGetGameEffect( hooman, "DAMAGE_MULTIPLIER" ), "frames", 0 )
	ComponentSetValue2( GetGameEffectLoadTo( pen.get_child( l_arm, "arm_r" ), "DAMAGE_MULTIPLIER", true ), "frames", -1 )
end