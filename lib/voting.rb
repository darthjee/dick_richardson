require './lib/pack'

class Voting
  attr_reader :file, :error

  def initialize(file, error: nil)
    @file = file
    @error = error
  end

  def vote(times, expected: nil, initial: nil, final: nil, error: nil)
    Pack.new(
      file, times,
      initial: initial || expected,
      final: final || initial || expected,
      error: error || self.error,
      average: average
    ).vote
  end

  private

  def average
    @average ||= Average.new
  end
end
