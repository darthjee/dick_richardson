module Voting
  class Parser
    class Partial
      include Arstotzka

      attr_reader :json
      expose :votes, full_path: 'ea', type: :integer
      expose :candidates, full_path: 'cand', klass: Parser::Candidate

      def initialize(json)
        @json = json
      end
    end
  end
end

