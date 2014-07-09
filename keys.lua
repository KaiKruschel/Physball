function set_keyboard(t)
  -- Player 1
  t.p1 = {}
  t.p1.up       = "w"
  t.p1.down     = "s"
  t.p1.left     = "a"
  t.p1.right    = "d"
  t.p1.turn_ccw = "q"
  t.p1.turn_cw  = "e"

  -- Player 2
  t.p2 = {}
  t.p2.up       = "up"
  t.p2.down     = "down"
  t.p2.left     = "left"
  t.p2.right    = "right"
  t.p2.turn_ccw = "appback"
  t.p2.turn_cw  = "appforward"
end
