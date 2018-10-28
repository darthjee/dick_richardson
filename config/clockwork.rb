require './config/boot'
require './config/environment'

include Clockwork

handler do |job|
  puts "Running #{job}"
end

every 90.seconds, 'Processor.new.process' do
  processor = Voting::Processor.new
  Rails.logger.info("Current partials: #{processor.partials.count}")
  processor.process
  Rails.logger.info("New Partials: #{processor.partials.count}")
end
