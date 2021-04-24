module Voting
  class Parser
    class Candidate
      include Arstotzka

      attr_reader :json
      expose :name, full_path: 'nm'
      expose :votes, full_path: 'v', type: :integer

      def initialize(json)
        @json = json
      end
    end
  end
end

