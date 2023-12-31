GUI_STRUCT.custom.twin_linked = function( gui, uid, screen_w, screen_h, data, zs, xys )
    local pic_x, pic_y = xys.inv_root_orig[1] - 1, xys.full_inv[2] + 1

    if( not( data.is_opened )) then
        local left_one = ( EntityGetWithTag( "left_linked" ) or {})[1]
        if( left_one ~= nil ) then
            local this_info = from_tbl_with_id( data.item_list, left_one, nil, nil, {})
            if( this_info.id ~= nil ) then
                local mana_max, mana = this_info.wand_info.mana_max, this_info.wand_info.mana
                do
                    local value = { math.min( math.max( mana, 0 ), mana_max ), mana_max }
                    uid = new_vanilla_bar( gui, uid, pic_x, pic_y, {zs.main_back,zs.main}, {16,2,16*math.min( value[1]/value[2], 1 )}, "data/ui_gfx/hud/colors_mana_bar.png" )
                    pic_y = pic_y + 6
                end
                data.memo.reload_max = data.memo.reload_max or {}
                if( not( this_info.wand_info.never_reload )) then
                    local reloading = this_info.wand_info.reload_frame
                    data.memo.reload_max[left_one] = ( data.memo.reload_max[left_one] or -1 ) < reloading and reloading or data.memo.reload_max[left_one]
                    if( data.memo.reload_max[left_one] > data.reload_threshold ) then
                        uid = new_vanilla_bar( gui, uid, pic_x, pic_y, {zs.main_back,zs.main}, {16,2,16*reloading/data.memo.reload_max[left_one]}, "data/ui_gfx/hud/colors_reload_bar.png" )
                        pic_y = pic_y + 6
                    end
                end
                data.memo.delay_max = data.memo.delay_max or {}
                do
                    local cast_delay = this_info.wand_info.delay_frame
                    data.memo.delay_max[left_one] = ( data.memo.delay_max[left_one] or -1 ) < cast_delay and cast_delay or data.memo.delay_max[left_one]
                    if( data.memo.delay_max[left_one] > data.delay_threshold ) then
                        uid = new_vanilla_bar( gui, uid, pic_x, pic_y, {zs.main_back,zs.main}, {16,2,16*cast_delay/data.memo.delay_max[left_one]}, "data/ui_gfx/hud/colors_reload_bar.png" )
                        pic_y = pic_y + 6
                    end
                end
                if(( this_info.wand_info.reload_frame or 0 ) == 0 ) then
                    data.memo.reload_max[left_one] = nil
                end
                if(( this_info.wand_info.delay_frame or 0 ) == 0 ) then
                    data.memo.delay_max[left_one] = nil
                end
            end
        end
    end

    return uid, data, {pic_x,pic_y}
end