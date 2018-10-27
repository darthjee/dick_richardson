require 'darthjee/core_ext'

require './lib/average'
require './lib/urna'

n_times = 10000
initial = 0.7
final = 0.4
diff = final - initial

averages = {
  d: Average.new,
  a: Average.new
}

f = File.open('dilma.dat', 'w')
f.write("#id\tAecio\tDilma\n")

n_times.times do |i|
  expected = initial + diff * i / n_times

  urna = Urna.new(expected, error: 0.5)
  a = urna.read
  d = 1 - a

  averages[:d] + d
  averages[:a] + a

  d = averages[:d].average
  a = averages[:a].average

  f.write("#{i}\t#{a}\t#{d}\n")
end

f.close
