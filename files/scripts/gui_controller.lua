
return function( pic_x, pic_y, inv_info, xys, slot_func )
    local inv_id = inv_info.id
    if( EntityGetRootEntity( inv_id ) ~= index.D.player_id ) then return end
    
    if( ComponentGetValue2( index.D.Controls.comp, "mButtonDownRightClick" )) then
        if( not( index.M.twin_linked_ignore )) then
            if( pen.vld( index.D.active_info ) and not( index.D.active_info.uses_rmb )) then
                ComponentSetValue2( EntityGetFirstComponentIncludingDisabled(
                    EntityGetParent( inv_id ), "PlatformShooterPlayerComponent" ), "mForceFireOnNextUpdate", true )
            else index.M.twin_linked_ignore = true end
        end
    else index.M.twin_linked_ignore = false end

    if( not( pen.vld( index.D.item_list ))) then return end

    local wand_id = index.D.slot_state[ inv_id ][1][1]
    local core_x, core_y = unpack( xys.inv_root_orig )
    index.new_generic_slot( core_x - 19, core_y, {
        inv_slot = { 1, 1 },
        inv_id = inv_id, id = wand_id,
    }, index.D.is_opened, true, true )
end