dofile_once("data/scripts/lib/utilities.lua")

--switch to default anim on empty hand
--add a 5th slot with dragging support (add to hand inventory and manually set the mActiveItem)
--remove inherit comps from wands

function new_image( gui, uid, pic_x, pic_y, pic_z, pic, s_x, s_y, alpha, interactive )
	if( s_x == nil ) then
		s_x = 1
	end
	if( s_y == nil ) then
		s_y = 1
	end
	if( alpha == nil ) then
		alpha = 1
	end
	if( interactive == nil ) then
		interactive = false
	end
	
	if( not( interactive )) then
		GuiOptionsAddForNextWidget( gui, 2 ) --NonInteractive
	end
	GuiZSetForNextWidget( gui, pic_z )
	uid = uid + 1
	GuiIdPush( gui, uid )
	GuiImage( gui, uid, pic_x, pic_y, pic, alpha, s_x, s_y )
	return uid
end

function new_button( gui, uid, pic_x, pic_y, pic_z, pic )
	GuiZSetForNextWidget( gui, pic_z )
	uid = uid + 1
	GuiIdPush( gui, uid )
	GuiOptionsAddForNextWidget( gui, 6 ) --NoPositionTween
	GuiOptionsAddForNextWidget( gui, 4 ) --ClickCancelsDoubleClick
	GuiOptionsAddForNextWidget( gui, 21 ) --DrawNoHoverAnimation
	GuiOptionsAddForNextWidget( gui, 47 ) --NoSound
	local clicked, r_clicked = GuiImageButton( gui, uid, pic_x, pic_y, "", pic )
	return uid, clicked, r_clicked
end

if( gui == nil ) then
	gui = GuiCreate()
end
GuiStartFrame( gui )
local l_hand = GetUpdatedEntityID()
local hooman = EntityGetRootEntity( l_hand )

local uid = 0
local pic_x, pic_y = 0, 0
local current_item = ComponentGetValue2( EntityGetFirstComponentIncludingDisabled( l_hand, "Inventory2Component" ), "mActiveItem" )
if( GameIsInventoryOpen()) then
	pic_x = 2
	pic_y = 17
	uid, clicked, r_clicked = new_button( gui, uid, pic_x, pic_y, -1, "mods/Twin-Linked/files/pics/main_button.png" )
	if( clicked ) then
		if( current_item ~= 0 ) then
			EntityRemoveTag( current_item, "is_lefted" )
			EntitySetComponentsWithTagEnabled( l_hand, "pickuper", false )
			GameDropAllItems( l_hand )
		else
			local p_x, p_y, p_r, p_s_x, p_s_y = EntityGetTransform( hooman )
			local wands = EntityGetInRadiusWithTag( p_x, p_y, 10, "wand" ) or {}
			if( #wands > 0 ) then
				local item_id = 0
				local dist = -1
				for i,wand_id in ipairs( wands ) do
					if( EntityGetRootEntity( wand_id ) == wand_id ) then
						local w_x, w_y, w_r, w_s_x, w_s_y = EntityGetTransform( wand_id )
						local w_dist = math.sqrt(( p_x - w_x )^2 + ( p_y - w_y )^2 )
						if( w_dist < dist or dist < 0 ) then
							item_id = wand_id
							dist = w_dist
						end
					end
				end
				
				if( item_id ~= 0 ) then
					EntityAddTag( item_id, "is_lefted" )
					EntitySetComponentsWithTagEnabled( l_hand, "pickuper", true )
					GamePickUpInventoryItem( l_hand, item_id, true )
					
					local sprite_comp = EntityGetFirstComponentIncludingDisabled( item_id, "SpriteComponent", "item" )
					ComponentSetValue2( sprite_comp, "z_index", 0.62 )
					EntityRefreshSprite( item_id, sprite_comp )
				else
					GamePrint( "None found!" )
				end
			else
				GamePrint( "None found!" )
			end
		end
	end
else
	local wand_id = current_item or 0

	if( wand_id ~= 0 ) then
		local abil_comp = EntityGetFirstComponentIncludingDisabled( wand_id, "AbilityComponent" )
		
		local mana_current = ComponentGetValue2( abil_comp, "mana" )
		local mana_max = ComponentGetValue2( abil_comp, "mana_max" )
		local reload_frame = ComponentGetValue2( abil_comp, "mReloadNextFrameUsable" )
		local reload_time = ComponentObjectGetValue2( abil_comp, "gun_config", "reload_time" ) 
		local delay_end = ComponentGetValue2( abil_comp, "mNextFrameUsable" )
		local delay_start = ComponentGetValue2( abil_comp, "mCastDelayStartFrame" ) 
		
		local frame_num = GameGetFrameNum()
		
		pic_x = 20
		pic_y = 41
		if( mana_max ~= 0 ) then
			local mana_persent = mana_current/mana_max
			uid = new_image( gui, uid, pic_x, pic_y, -1, "data/ui_gfx/hud/mana.png" )
			uid = new_image( gui, uid, pic_x + 8, pic_y + 1, -1, "mods/Twin-Linked/files/pics/back.png" )
			uid = new_image( gui, uid, pic_x + 9, pic_y + 2, -1.1, "data/ui_gfx/hud/colors_mana_bar.png", 20*mana_persent, 1 )
			pic_y = pic_y + 8
		end
		
		if( delay_time ~= 0 and reload_frame < frame_num ) then
			local delay_persent = ( delay_end - frame_num )/( delay_end - delay_start )
			if( delay_persent > 0 ) then
				uid = new_image( gui, uid, pic_x, pic_y, -1, "data/ui_gfx/hud/fire_rate_wait.png" )
				uid = new_image( gui, uid, pic_x + 8, pic_y + 1, -1, "mods/Twin-Linked/files/pics/back.png" )
				uid = new_image( gui, uid, pic_x + 9, pic_y + 2, -1.1, "data/ui_gfx/hud/colors_mana_bar.png", 20*( 1 - delay_persent ), 1 )
				pic_y = pic_y + 8
			end
		end
		
		if( reload_time ~= 0 ) then
			local reload_persent = ( reload_frame - frame_num )/reload_time
			if( reload_persent > 0 ) then
				uid = new_image( gui, uid, pic_x, pic_y, -1, "data/ui_gfx/hud/reload.png" )
				uid = new_image( gui, uid, pic_x + 8, pic_y + 1, -1, "mods/Twin-Linked/files/pics/back.png" )
				uid = new_image( gui, uid, pic_x + 9, pic_y + 2, -1.1, "data/ui_gfx/hud/colors_reload_bar.png", 20*( 1 - reload_persent ), 1 )
			end
		end
	end
end