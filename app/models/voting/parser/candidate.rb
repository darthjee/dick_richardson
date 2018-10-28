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

      def votes
        hash['v'].to_i
      end
    end
  end
end

