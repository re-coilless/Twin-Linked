return function( data, inv_data, info_old, info_new )
    local john_arm = EntityGetParent( inv_data.id )
    ComponentSetValue2( EntityGetFirstComponentIncludingDisabled( john_arm, "PlatformShooterPlayerComponent" ), "mForceFireOnNextUpdate", false )

    local is_linked, update_the_thing = EntityHasTag( data.player_id, "twin_linked" ), false
    if( info_old.id ~= nil ) then
        EntityRemoveTag( info_old.id, "left_linked" )
    elseif( not( is_linked )) then
        update_the_thing = 1
    end
    if( info_new.id ~= nil ) then
        EntityAddTag( info_new.id, "left_linked" )

        local pic_comps = EntityGetComponentIncludingDisabled( info_new.id, "SpriteComponent", "item" ) or {}
        if( #pic_comps > 0 ) then
            for i,comp in ipairs( pic_comps ) do
                ComponentSetValue2( comp, "z_index", 0.62 + ( i - 1 )*0.0001 )
                EntityRefreshSprite( info_new.id, comp )
            end
        end
    elseif( is_linked ) then
        update_the_thing = 2
    end

    if( update_the_thing ) then
        local is_twin = update_the_thing == 1
        if( is_twin ) then
            EntityAddTag( data.player_id, "twin_linked" )
        else
            EntityRemoveTag( data.player_id, "twin_linked" )
        end

        local pic_comp = EntityGetFirstComponentIncludingDisabled( data.player_id, "SpriteComponent", "character" )
        ComponentSetValue2( pic_comp, "image_file", is_twin and "mods/Twin-Linked/files/pics/player_handless.xml" or "data/enemies_gfx/player.xml" )
        local pic_comps = EntityGetComponentIncludingDisabled( data.player_id, "SpriteComponent" ) or {}
        for i,comp in ipairs( pic_comps ) do
            EntityRefreshSprite( data.player_id, comp )
        end

        john_arm = get_hooman_child( john_arm, "arm_r" )
        pic_comp = EntityGetFirstComponentIncludingDisabled( john_arm, "SpriteComponent" )
        ComponentSetValue2( pic_comp, "alpha", 2 - update_the_thing )
        EntityRefreshSprite( john_arm, pic_comp )
    end

    return true
end