class Urna
  attr_reader :expected, :error

  def initialize(expected, error: 0.1)
    @expected = expected
    @error = error
  end

  def read
    expected * factor
  end

  private

  def factor
    1 - error + random_factor
  end

  def random_factor
    2 * error * Random.rand
  end
end
