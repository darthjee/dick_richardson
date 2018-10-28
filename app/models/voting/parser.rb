module Voting
  class Parser
    attr_reader :raw

    def initialize(raw)
      @raw = raw
    end

    def votes
      hash['ea'].to_i
    end

    def candidates
      hash['cand'].map do |hash|
        Parser::Candidate.new(hash)
      end
    end

    private

    def hash
      @hash ||= JSON.parse(raw)
    end
  end
end
