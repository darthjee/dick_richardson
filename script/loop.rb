class Looper
  delegate :active, to: :voting

  def voting
    Voting::Voting.first
  end

  def do_the_loop
    Voting::Processor.new.process
    puts "Current: #{voting.partials.count}"
    sleep sleep_time
  rescue Exception => e
    puts "Error: #{e}"
  end

  def sleep_time
    60 + Random.rand(10)
  end
end

looper = Looper.new
while looper.active do
  looper.do_the_loop
end
