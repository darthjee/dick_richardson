module Voting
  class PartialCandidate < ActiveRecord::Base
    belongs_to :partial
    belongs_to :candidate
  end
end


