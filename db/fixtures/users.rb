User.seed do |s|
  s.id = 1
  s.name = 'Mike Glaz'
  s.email = 'mikeglaz@yahoo.com'
  s.password = 'a'
  s.admin = true
  s.activated = true
end

User.seed do |s|
  s.id = 2
  s.name = 'Mike Gmail'
  s.email = 'mikeglaz@gmail.com'
  s.password = 'a'
  s.admin = false
  s.activated = true
end
