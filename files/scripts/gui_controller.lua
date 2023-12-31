
return function( gui, uid, pic_x, pic_y, inv_data, data, zs, xys, slot_func )
    local inv_id = inv_data.id
    if( EntityGetRootEntity( inv_id ) == data.player_id ) then
        if( ComponentGetValue2( data.Controls[1], "mButtonDownRightClick" )) then
            if( not( data.memo.twin_linked_ignore )) then
                if( data.active_info ~= nil and not( data.active_info.uses_rmb )) then
                    ComponentSetValue2( EntityGetFirstComponentIncludingDisabled( EntityGetParent( inv_id ), "PlatformShooterPlayerComponent" ), "mForceFireOnNextUpdate", true )
                else
                    data.memo.twin_linked_ignore = true
                end
            end
        else
            data.memo.twin_linked_ignore = false
        end

        local this_data = data.item_list
        if( #this_data > 0 ) then
            local w, h, step = 0, 0, 1

            local wand_id = data.slot_state[ inv_id ][1][1]
            local core_x, core_y = unpack( data.xys.inv_root_orig )
			uid, data, w, h = slot_setup( gui, uid, core_x - 19, core_y, zs, data, {
				inv_id = inv_id,
				id = wand_id,
				inv_slot = {1,1},
			}, data.is_opened, true, true )
		end
    end

    return uid, data
end