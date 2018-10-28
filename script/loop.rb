class Looper
  delegate :active, to: :voting

  def voting
    Voting::Voting.first
  end

  def do_the_loop
    Voting::Processor.new.process
    puts "Current: #{voting.partials.count}"
    sleep 60
  rescue Exception => e
    puts "Error: #{e}"
  end
end

looper = Looper.new
while looper.active do
  looper.do_the_loop
end
