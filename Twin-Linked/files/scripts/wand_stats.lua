local GLOBAL_MODES, GLOBAL_MUTATORS, APPLETS, BOSS_BARS,
	WAND_STATS, SPELL_STATS, MATTER_DESCS, ITEM_CATS, GUI_MODULES, GUI_STRUCT = unpack( index.STRUCT )

GUI_MODULES.custom.twin_linked = function( xD, xM, screen_w, screen_h, pos )
    if( not( pen.vld( xD.xys.inv_root ))) then return end
    local pic_x, pic_y = xD.xys.inv_root[1] - 1, xD.xys.inv_end_edge[2] + 1

    pen.hallway( function()
        if( xD.is_opened ) then return end

        local left_id = ( EntityGetWithTag( "left_linked" ) or {})[1]
        if( not( pen.vld( left_id, true ))) then return end

        local info = xM.item_memo[ left_id ] or {}
        if( not( pen.vld( info.id, true ))) then return end

        local mana_max, mana = info.wand_info.mana_max, info.wand_info.mana
        local value = { math.min( math.max( mana, 0 ), mana_max ), mana_max }
        xD.bar_func( pic_x, pic_y, pen.Z.MAIN - 5,
            { 16, 2, 16*math.min( value[1]/value[2], 1 )}, pen.P.VNL.MANA )
        pic_y = pic_y + 6

        xM.reload_max = xM.reload_max or {}
        if( not( info.wand_info.never_reload )) then
            local reloading = info.wand_info.reload_frame
            xM.reload_max[ left_id ] =
                ( xM.reload_max[ left_id ] or -1 ) < reloading and reloading or xM.reload_max[ left_id ]
            if( xM.reload_max[ left_id ] > xD.reload_threshold ) then
                xD.bar_func( pic_x, pic_y, pen.Z.MAIN - 5,
                    { 16, 2, 16*reloading/xM.reload_max[ left_id ]}, pen.P.VNL.CAST )
                pic_y = pic_y + 6
            end
        end

        xM.delay_max = xM.delay_max or {}
        local cast_delay = info.wand_info.delay_frame
        xM.delay_max[ left_id ] =
            ( xM.delay_max[ left_id ] or -1 ) < cast_delay and cast_delay or xM.delay_max[ left_id ]
        if( xM.delay_max[ left_id ] > xD.reload_threshold ) then
            xD.bar_func( pic_x, pic_y, pen.Z.MAIN - 5,
                { 16, 2, 16*cast_delay/xM.delay_max[ left_id ]}, pen.P.VNL.CAST )
            pic_y = pic_y + 6
        end
        
        if(( info.wand_info.reload_frame or 0 ) == 0 ) then xM.reload_max[ left_id ] = nil end
        if(( info.wand_info.delay_frame or 0 ) == 0 ) then xM.delay_max[ left_id ] = nil end
    end)

    return { pic_x, pic_y }
end