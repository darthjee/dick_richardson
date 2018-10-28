module Voting
  class Candidate < ActiveRecord::Base
    belongs_to :voting
  end
end

