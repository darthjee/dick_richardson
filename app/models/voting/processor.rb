module Voting
  class Processor
    delegate :votes, :candidates, :raw, to: :parser

    delegate :partials, to: :voting

    attr_reader :voting, :partial

    def initialize(voting = ::Voting::Voting.first)
      @voting = voting
    end

    def process
      return unless voting.active
      return unless new_entry?
      create_partial
      create_partial_candidates
    end

    private

    def create_partial
      @partial = partials.create(votes: votes, raw: raw)
    end

    def create_partial_candidates
      candidates.each do |candidate|
        voting_candidate = voting.candidates.find_or_create_by(name: candidate.name)

        partial.partial_candidates.create(candidate: voting_candidate, votes: candidate.votes)
      end
    end

    def new_entry?
      return true if partials.empty?
      votes > partials.maximum(:votes)
    end

    def client
      @client ||= Client.new
    end

    def parser
      @parser ||= Parser.new(client.get)
    end
  end
end
