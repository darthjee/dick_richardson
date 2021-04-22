module Voting
  class Candidate < ActiveRecord::Base
    belongs_to :voting

    has_many :partials, class_name: 'Voting::PartialCandidate'
  end
end

