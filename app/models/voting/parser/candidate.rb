module Voting
  class Parser
    class Candidate
      attr_reader :hash

      def initialize(hash)
        @hash = hash
      end
    end
  end
end

