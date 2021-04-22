h = Hash.new { 0 }
100.times do |n|
  #i = (Random.rand(10000) + 1).to_s[0]
  i = (n+1).to_s[0]
  h[i] = h[i] + 1
end
puts h
