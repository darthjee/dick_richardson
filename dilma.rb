require 'darthjee/core_ext'

require './lib/voting'

n_times = 10000
initial = 0.7
final = 0.3
diff = final - initial

averages = {
  d: Average.new,
  a: Average.new
}

f = File.open('dilma.dat', 'w')
f.write("#id\tAecio\tDilma\n")

voting = Voting.new(f, error: 0.4)

voting.vote(500, initial: 0.7, final: 0.5)
voting.vote(5000, expected: 0.48)

f.close
