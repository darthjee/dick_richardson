module Voting
  class Voting < ActiveRecord::Base
    has_many :partials
    has_many :candidates
  end
end
