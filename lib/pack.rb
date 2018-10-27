require './lib/urna'
require './lib/average'

class Pack
  attr_reader :file, :average, :times, :initial, :final, :error, :last, :last_delta, :last_delta2

  def initialize(file, times, average: Average.new, initial:, final: nil, error: 0.1, last: 0, last_delta: 0, last_delta2: 0)
    @file = file
    @average = average
    @times = times
    @initial = initial
    @final = final || initial
    @error = error
    @last = last
    @last_delta = last_delta
    @last_delta2 = last_delta2
  end

  def vote
    times.times do |i|
      expected = initial + diff * i / times
      urna = Urna.new(expected, error: error)

      average + urna.read

      c = average.length
      a = average.average
      d = 1 - a
      delta = a - last
      delta2 = delta - last_delta
      delta3 = delta2 - last_delta2

      indicator = (delta3 - delta3.abs) / (2 * delta3)

      @last = a
      @last_delta = delta
      @last_delta2 = delta2

      file.write("#{c}\t#{a}\t#{d}\t#{delta}\t#{delta2}\t#{delta3}\t#{indicator}\n")
    end
  end

  private

  def diff
    @diff ||= final - initial
  end
end
