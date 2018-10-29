require 'spec_helper'

describe Voting::Parser::Candidate do
  subject(:candidate) { described_class.new(hash) }

  let(:voting_hash) { load_json_fixture_file('voting/tse_response_partial.json') }
  let(:hash)        { voting_hash['cand'].last }

  describe '#name' do
    it 'fetches the name from the hash' do
      expect(subject.name).to eq('FERNANDO HADDAD')
    end
  end

  describe '#votes' do
    it 'votes' do
      expect(subject.votes).to eq(47040574)
    end
  end
end
