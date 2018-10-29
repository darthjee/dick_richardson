require 'spec_helper'

describe Voting::Parser::Partial do
  subject(:partial) { described_class.new(hash) }

  let(:hash) { load_json_fixture_file('voting/tse_response_partial.json') }

  describe '#votes' do
    it 'votes' do
      expect(partial.votes).to eq(147303938)
    end
  end

  describe '#candidates' do
    it do
      expect(partial.candidates).to be_a(Array)
    end

    it 'returns candidates' do
      expect(partial.candidates.last).to be_a(Voting::Parser::Candidate)
      expect(partial.candidates.last.name).to eq('FERNANDO HADDAD')
    end
  end
end

