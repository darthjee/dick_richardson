module Voting
  class Processor
    delegate :votes, :candidates, to: :parser
    private

    def client
      @client ||= Client.new
    end

    def parser
      @parser ||= Parser.new(client.get)
    end
  end
end
