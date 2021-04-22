module Simulation
  class Simulation < ActiveRecord::Base
    has_many :ballots

    def partials
      Partial.joins(:ballot).where(simulation_ballots: { simulation_id: id })
    end
  end
end
