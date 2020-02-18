date = DateTime.current

Event.seed do |s|
  s.id = 1
  s.user_id = 1
  s.venue_id = 3
  s.name = 'Slayer'
  s.description = 'The Tour To End All Tours'
  s.date = DateTime.new(date.year, date.month - 1, date.last_month.end_of_month.day, 19, 0, 0)
end

Event.seed do |s|
  s.id = 2
  s.user_id = 1
  s.venue_id = 3
  s.name = 'Ghost'
  s.description = 'A Pale Tour Named Death'
  s.date = DateTime.new(date.year, date.month, 1, 19, 0, 0)
end

Event.seed do |s|
  s.id = 3
  s.user_id = 2
  s.venue_id = 1
  s.name = 'Metallica'
  s.description = "Justice For All Tour #{date.year}"
  s.date = DateTime.new(date.year, date.month, 12, 19, 0, 0)
end

Event.seed do |s|
  s.id = 4
  s.user_id = 2
  s.venue_id = 2
  s.name = 'Arcturus'
  s.description = "Church Burning Tour #{date.year}"
  s.date = DateTime.new(date.year, date.month, 20, 19, 0, 0)
end

Event.seed do |s|
  s.id = 5
  s.user_id = 2
  s.venue_id = 2
  s.name = 'Dissection'
  s.description = "Somberlain Tour #{date.year}"
  s.date = DateTime.new(date.year, date.month, 20, 19, 0, 0)
end

Event.seed do |s|
  s.id = 6
  s.user_id = 2
  s.venue_id = 2
  s.name = 'Sentenced'
  s.description = "Funeral Spring Tour #{date.year}"
  s.date = DateTime.new(date.year, date.month, date.end_of_month.day, 19, 0, 0)
end

Event.seed do |s|
  s.id = 7
  s.user_id = 3
  s.venue_id = 3
  s.name = 'Opeth'
  s.description = 'Blackwater Park Tour'
  s.date = DateTime.new(date.year, date.month + 1, 1, 19, 0, 0)
end

Event.seed do |s|
  s.id = 8
  s.user_id = 1
  s.venue_id = 3
  s.name = 'Animals As Leaders'
  s.description = 'Tempting Death Tour'
  s.date = DateTime.new(date.year, date.month + 1, 3, 19, 0, 0)
end
