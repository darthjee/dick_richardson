require './lib/pack'

class Voting
  attr_reader :file, :error

  def initialize(file, error: nil)
    @file = file
    @error = error
  end

  def vote(times, expected: nil, initial: nil, final: nil, error: nil)
    pack = Pack.new(
      file, times,
      initial: initial || expected,
      final: final || initial || expected,
      error: error || self.error,
      average: average,
      last: last,
      last_delta: last_delta,
      last_delta2: last_delta2
    )
      
    pack.vote

    @last = pack.last
    @last_delta = last_delta
    @last_delta2 = last_delta2
  end

  private

  def average
    @average ||= Average.new
  end

  def last
    @last ||= 0
  end

  def last_delta
    @last_delta ||= 0
  end

  def last_delta2
    @last_delta2 ||= 0
  end
end
