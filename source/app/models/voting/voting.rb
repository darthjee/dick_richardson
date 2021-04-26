module Voting
  class Voting < ActiveRecord::Base
    has_many :partials
    has_many :candidates

    def final_result
      partials.last&.candidates
    end
  end
end
