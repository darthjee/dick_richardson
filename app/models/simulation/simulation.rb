module Simulation
  class Simulation < ActiveRecord::Base
    has_many :ballots
  end
end
