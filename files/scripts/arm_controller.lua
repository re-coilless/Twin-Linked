local l_arm = GetUpdatedEntityID()
local hooman = EntityGetRootEntity( l_arm )

local aim_x, aim_y = ComponentGetValue2( EntityGetFirstComponentIncludingDisabled( hooman, "ControlsComponent" ), "mAimingVector" )
ComponentSetValueVector2( EntityGetFirstComponentIncludingDisabled( l_arm, "ControlsComponent" ), "mAimingVector", aim_x, aim_y )

local RMB_down = ComponentGetValue2( EntityGetFirstComponentIncludingDisabled( hooman, "ControlsComponent" ), "mButtonDownRightClick" )
if( RMB_down and not( GameIsInventoryOpen())) then
	ComponentSetValue2( EntityGetFirstComponentIncludingDisabled( l_arm, "PlatformShooterPlayerComponent" ), "mForceFireOnNextUpdate", true )
end

--redo akimbo controls
--put the wand in the player's inventory while not firing but still put the wand at the hand's spot

-- local x, y = EntityGetTransform( hooman )
-- local m_x, m_y = DEBUG_GetMouseWorld()
-- aim_x, aim_y = m_x - x, m_y - y

-- ComponentSetValue2( ctrl_comp, "mButtonDownLeft", rlin[1] or ctrl_tbl[1] < 0 )
-- ComponentSetValue2( ctrl_comp, "mButtonDownRight", rlin[2] or ctrl_tbl[1] > 0 )
-- ComponentSetValue2( ctrl_comp, "mButtonDownDown", rlin[3] or ctrl_tbl[2] < 0 )
-- ComponentSetValue2( ctrl_comp, "mButtonDownFly", gonna_fly )
-- ComponentSetValue2( ctrl_comp, "mFlyingTargetY", -999999 )
-- if( gonna_fly ) then
-- 	local plat_comp = EntityGetFirstComponentIncludingDisabled( hooman, "CharacterPlatformingComponent" )
-- 	ComponentSetValue2( plat_comp, "keyboard_look", false )
-- 	ComponentSetValue2( plat_comp, "mouse_look", true )
-- end
-- ComponentSetValue2( ctrl_comp, "mButtonDownFire", gonna_shoot )
-- ComponentSetValue2( ctrl_comp, "mAimingVector", aim_x, aim_y )
-- ComponentSetValue2( ctrl_comp, "mMousePosition", aim_x*1000, aim_y*1000 )