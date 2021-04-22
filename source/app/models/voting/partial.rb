module Voting
  class Partial < ActiveRecord::Base
    belongs_to :voting
    has_many :partial_candidates
    has_many :candidates, class_name: 'Voting::PartialCandidate'

    def raw_hash
      JSON.parse(raw)
    end
  end
end
