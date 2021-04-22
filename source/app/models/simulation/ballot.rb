module Simulation
  class Ballot < ActiveRecord::Base
    belongs_to :simulation
    has_one :partial

    def create_partial
      save!
      partial || Partial.create(ballot: self, percentage: partial_percentage)
    end

    private

    def partial_percentage
      partial&.percentage ||
        simulation.ballots.where('id <= ?', id).average(:percentage)
    end
  end
end
