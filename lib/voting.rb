require './lib/urna'
require './lib/average'

class Voting
  attr_reader :file, :average, :times, :initial, :final, :error

  def initialize(file, times, average: Average.new, initial:, final: nil, error: 0.1)
    @file = file
    @average = average
    @times = times
    @initial = initial
    @final = final || initial
    @error = error
  end

  def vote
    times.times do |i|
      expected = initial + diff * i / times
      urna = Urna.new(expected, error: error)

      average + urna.read

      c = average.length
      a = average.average
      d = 1 - a

      file.write("#{c}\t#{a}\t#{d}\n")
    end
  end

  private

  def diff
    @diff ||= final - initial
  end
end
