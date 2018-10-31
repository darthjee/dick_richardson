module Voting
  class Worker
    attr_reader :voting

    def initialize(voting  = ::Voting::Voting.first)
      @voting = voting
    end

    def perform
      processor.process
    end

    private

    def client
      @client ||= Client.new
    end

    def processor
      @processor ||= Processor.new(voting, raw: client.get)
    end
  end
end
