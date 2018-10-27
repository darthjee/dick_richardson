f = File.open('benfor3.dat', 'r')

h = Hash.new { 0 }

f.each do |l|
  h[l] = h[l] + 1
end

puts h
f.close
