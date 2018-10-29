module Voting
  class Parser
    attr_reader :raw
    delegate :votes, :candidates, to: :partial

    def initialize(raw)
      @raw = raw
    end

    private

    def partial
      Parser::Partial.new(hash)
    end

    def hash
      @hash ||= JSON.parse(raw)
    end
  end
end
