module Voting
  class Parser
    attr_reader :hash
    delegate :votes, :candidates, to: :partial

    def initialize(hash)
      @hash = hash
    end

    private

    def partial
      Parser::Partial.new(hash)
    end
  end
end
