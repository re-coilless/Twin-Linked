local l_arm = GetUpdatedEntityID()
local hooman = EntityGetRootEntity( l_arm )
local angery_comp = GameGetGameEffect( hooman, "BERSERK" )

--glass cannon support
if( angery_comp ~= 0 ) then
	local duration = ComponentGetValue2( angery_comp, "frames" )
	local pissed_comp = GameGetGameEffect( l_arm, "BERSERK" )
	if( pissed_comp ~= 0 ) then
		ComponentGetValue2( pissed_comp, "frames", duration )
	else
		ComponentSetValue2( GetGameEffectLoadTo( l_arm, "BERSERK", true ), "frames", 1 )
	end
else
	local pissed_comp = GameGetGameEffect( l_arm, "BERSERK" )
	if( pissed_comp ~= 0 ) then
		EntityRemoveComponent( l_arm, pissed_comp )
	end
end