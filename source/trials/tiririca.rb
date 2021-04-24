require 'darthjee/core_ext'

keys = 10.times.map(&:to_s)

tiririca = Hash.new { 0 }
malafaia = Hash.new { 0 }
dilma = Hash.new { 0 }

1000.times do |n|
  p = 13
  pr = p - 5 + Random.rand(11)
  i = pr.to_s[0]
  tiririca[i] = tiririca[i] + 1
end

1000.times do |n|
  p = 8
  pr = p - (20 + Random.rand(21)) / 10.0
  i = pr.to_s[0]
  malafaia[i] = malafaia[i] + 1
end

1000.times do |n|
  p = 50
  pr = p - 3 + Random.rand(7)
  i = pr.to_s[0]
  dilma[i] = dilma[i] + 1
end

f = File.open('tiririca.dat', 'w')

f.write("#Valor\tT\tM\tD\n")
keys.each do |k|
  t = tiririca[k]
  m = malafaia[k]
  d = dilma[k]
  f.write("#{k}\t#{t}\t#{m}\t#{d}\n")
end
puts tiririca
f.close
