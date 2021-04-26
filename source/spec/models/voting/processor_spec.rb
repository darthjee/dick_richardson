require 'spec_helper'

describe Voting::Processor do
  describe '#process' do
    context 'when definig processor with raw json' do
      subject(:processor) { described_class.new(voting, raw: raw) }

      it_behaves_like 'a method that process votes entries', :process
    end

    context 'when definig processor with hash' do
      subject(:processor) { described_class.new(voting, hash: JSON.parse(raw)) }

      it_behaves_like 'a method that process votes entries', :process
    end
  end
end
