require 'spec_helper'

describe Voting::Partial do
  subject(:partial) { create(:voting_partial, raw: raw) }

  let(:raw)  { load_fixture_file('voting/raw_first.json') }
  let(:hash) { load_json_fixture_file('voting/raw_first.json') }

  describe '#raw_hash' do
    it do
      expect(partial.raw_hash).to be_a(Hash)
    end

    it 'parses the raw hash' do
      expect(partial.raw_hash).to eq(hash)
    end
  end
end
