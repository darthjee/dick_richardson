module Voting
  class Partial < ActiveRecord::Base
    belongs_to :voting
  end
end
