class Average
  def initialize(times=0, &block)
    self.times(times, &block)
  end

  def average
    return 0 unless length > 0
    sum * 1.0 / length
  end

  def times(count)
    count.times do |*args|
      self + yield(*args)
    end
    self
  end

  def +(value)
    self.sum += value
    self.length += 1
    self
  end

  def length
    @length ||= 0
  end

  def sum
    @sum ||= 0
  end

  private

  attr_writer :sum, :length
end

