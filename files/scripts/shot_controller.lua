function shot( proj_id ) --special thanks to ImmortalDamned for providing this fix!
    if(( proj_id or 0 ) > 0 ) then
        local arm_id = GetUpdatedEntityID()
        local hooman = EntityGetRootEntity( arm_id )
        local proj_comp = EntityGetFirstComponentIncludingDisabled( proj_id, "ProjectileComponent" ) or 0
        if( proj_comp > 0 and ComponentGetValue2( proj_comp, "mWhoShot" ) == arm_id ) then
            ComponentSetValue2( proj_comp, "mWhoShot", hooman )
        end
    end
end