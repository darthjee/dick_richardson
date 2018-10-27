f = File.open('benfor.txt', 'w')

1000000.times do
  i = Random.rand(1000) + 1
  f.write("#{i}\n")
end

f.close
