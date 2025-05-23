local entity_id, arm_id = GetUpdatedEntityID(), EntityGetWithName( "twin_linked_arm_l" ) or 0
if( arm_id > 0 ) then local x, y = EntityGetTransform( arm_id ); EntitySetTransform( entity_id, x, y ) end

local comp_id = GetUpdatedComponentID()
if( ComponentGetValue2( comp_id, "mTimesExecuted" ) > 5 ) then EntityKill( entity_id ) end