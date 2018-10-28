module Simulation
  class Simulation < ActiveRecord::Base
    has_many :ballots

    def partials
      Partial.where(ballot_id: ballots)
    end
  end
end
