
h = Hash.new { 0 }
100.times do |n|
  p = 8
  pr = p - 5 + Random.rand(11)
  i = pr.to_s[0]
  h[i] = h[i] + 1
end
puts h
