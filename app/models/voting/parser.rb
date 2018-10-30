module Voting
  class Parser
    attr_reader :hash
    delegate :votes, :candidates, to: :partial

    def initialize(hash: nil, raw: nil)
      @hash = hash
      @raw = raw
    end

    def hash
      @hash ||= JSON.parse(raw)
    end

    def raw
      @raw ||= hash.to_json
    end

    private

    def partial
      Parser::Partial.new(hash)
    end
  end
end
