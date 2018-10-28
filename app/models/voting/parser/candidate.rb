module Voting
  class Parser
    class Candidate
      attr_reader :hash

      def initialize(hash)
        @hash = hash
      end

      def name
        hash['nm']
      end
    end
  end
end

