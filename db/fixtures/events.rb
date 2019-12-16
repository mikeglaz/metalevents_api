Event.seed do |s|
  s.id = 1
  # s.user_id = 1
  # s.venue_id = 3
  s.venue = 'Regies Rock Club'
  s.name = 'Abigor'
  s.description = 'Nachthymnen Tour'
  s.date = DateTime.new(2019, 12, 29, 19, 0, 0)
end

Event.seed do |s|
  s.id = 2
  # s.user_id = 1
  # s.venue_id = 3
  s.venue = 'Regies Rock Club'
  s.name = 'Ghost'
  s.description = 'A Pale Tour Named Death'
  s.date = DateTime.new(2020, 1, 1, 19, 0, 0)
end

Event.seed do |s|
  s.id = 3
  # s.user_id = 2
  # s.venue_id = 1
  s.venue = 'Regies Rock Club'
  s.name = 'Metallica'
  s.description = 'World Tour 2019'
  s.date = DateTime.new(2020, 1, 31, 20, 0, 0)
end

Event.seed do |s|
  s.id = 4
  # s.user_id = 2
  # s.venue_id = 2
  s.venue = 'Regies Rock Club'
  s.name = 'Arcturus'
  s.description = 'Church Burning Tour 2019'
  s.date = DateTime.new(2020, 2, 1, 20, 0, 0)
end

Event.seed do |s|
  s.id = 5
  # s.user_id = 3
  # s.venue_id = 3
  s.venue = 'Regies Rock Club'
  s.name = 'Opeth'
  s.description = 'Blackwater Park Tour'
  s.date = DateTime.new(2020, 2, 5, 21, 0, 0)
end

Event.seed do |s|
  s.id = 6
  # s.user_id = 1
  # s.venue_id = 3
  s.venue = 'Regies Rock Club'
  s.name = 'Animals As Leaders'
  s.description = 'Tempting Death Tour'
  s.date = DateTime.new(2020, 3, 3, 19, 0, 0)
end
