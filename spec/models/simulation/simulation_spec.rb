require 'spec_helper'

describe Simulation::Simulation do
  subject(:simulation) { create(:simulation) }

  describe '#partials' do
    context 'when there are no partials' do
      it do
        expect(simulation.partials).to be_empty
      end

      it do
        expect(subject.partials).to be_a(ActiveRecord::Relation)
      end
    end

    context 'when there are partials' do
      let(:ballot_simulation) { simulation }

      before do
        create(:simulation_ballot, :with_partial, simulation: ballot_simulation)
      end

      context 'for the same simulation' do
        it do
          expect(simulation.partials).not_to be_empty
        end
      end

      context 'when creating a new partial' do
        it 'changes the partials return' do
          expect do
            create(:simulation_ballot, :with_partial, simulation: simulation)
          end.to change { simulation.partials.count }.by(1)
        end
      end

      context 'for other simulation' do
        let(:ballot_simulation) { create(:simulation) }

        it do
          expect(simulation.partials).to be_empty
        end
      end
    end
  end
end
