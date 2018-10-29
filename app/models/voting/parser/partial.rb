module Voting
  class Parser
    class Partial
      attr_reader :hash

      def initialize(hash)
        @hash = hash
      end

      def votes
        hash['ea'].to_i
      end

      def candidates
        hash['cand'].map do |hash|
          Parser::Candidate.new(hash)
        end
      end
    end
  end
end

