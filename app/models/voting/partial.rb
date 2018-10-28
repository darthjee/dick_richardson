module Voting
  class Partial < ActiveRecord::Base
    belongs_to :voting
    has_many :partial_candidates
  end
end
