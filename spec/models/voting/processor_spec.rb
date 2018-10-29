require 'spec_helper'

describe Voting::Processor do
  subject(:processor) { described_class.new(voting) }

  let(:voting) { create(:voting) }

  describe '#process' do
    context 'when there is no partial' do
      it do
        expect do
          processor.process
        end.to change { voting.partials.count }.by(1)
      end
    end
  end
end
