require 'spec_helper'

describe Voting::Processor do
  subject(:processor) { described_class.new(voting, raw: raw) }

  let(:voting) { create(:voting) }

  describe '#process' do
    let(:raw) { load_fixture_file('voting/tse_response_partial.json') }

    it_behaves_like "a method that process votes entries", :process
  end
end
