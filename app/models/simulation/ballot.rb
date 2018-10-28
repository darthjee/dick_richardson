module Simulation
  class Ballot < ActiveRecord::Base
    belongs_to :simulation
  end
end
