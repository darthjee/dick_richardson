require './config/boot'
require './config/environment'

include Clockwork

handler do |job|
  puts "Running #{job}"
end

every 90.seconds, 'Voting::Worker.new.perform' do
  worker = Voting::Worker.new
  Rails.logger.info("Current partials: #{worker.partials.count}")
  worker.perform
  Rails.logger.info("New Partials: #{worker.partials.count}")
end
