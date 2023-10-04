--special thanks to ImmortalDamned for providing this fix!

function shot( proj_id )
    --apply the recoil onto the player
    
    local hooman = EntityGetRootEntity( GetUpdatedEntityID())
    local proj_comp = EntityGetFirstComponentIncludingDisabled( proj_id, "ProjectileComponent" )
    ComponentSetValue2( proj_comp, "mWhoShot", hooman )
end