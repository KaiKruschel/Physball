function scoring (object_1, object_2, contact)
  if ( object_1:getCategory() + object_2:getCategory() == 7 ) then -- ball plus left wall
    score[2] = score[2] + 1
    do_reset = true
  elseif ( object_1:getCategory() + object_2:getCategory() == 9 ) then -- ball plus right wall
    score[1] = score[1] +1
    do_reset = true
  end
end

function reset()
  paddle1.body:setPosition( 20, screen_height/2 )
  paddle1.body:setLinearVelocity( 0, 0 )
  paddle1.body:setAngularVelocity( 0 )
  paddle1.body:setAngle( 0 )

  paddle2.body:setPosition( screen_width - 20, screen_height/2 )
  paddle2.body:setLinearVelocity( 0, 0 )
  paddle2.body:setAngularVelocity( 0 )
  paddle2.body:setAngle( 0 )

  ball.body:setPosition( screen_width/2, screen_height/2 )
  ball.body:setLinearVelocity( 0, 0 )
end
