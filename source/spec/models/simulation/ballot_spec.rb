require 'spec_helper'

describe Simulation::Ballot do
  describe '#create_partial' do
    subject(:ballot) do
      create(:simulation_ballot, percentage: percentage, simulation: simulation)
    end

    let(:percentage) { Random.rand(10000) / 10000.to_f }
    let(:simulation) { create(:simulation) }

    context 'when there is not partial for the ballot' do
      context 'when there are no older ballots' do
        it do
          expect do
            ballot.create_partial
          end.to change(Simulation::Ballot, :count).by(1)
        end

        it do
          expect do
            ballot.create_partial
          end.to change(subject, :partial).from(nil)
        end

        it do
          expect(ballot.create_partial).to be_a(Simulation::Partial)
        end

        it 'creates partial with the ballot percentage' do
          expect(ballot.create_partial.percentage).to eq(ballot.percentage)
        end
      end

      context 'when there are older ballots' do
        context 'for the simulation' do
          let!(:older_ballot) do
            create(:simulation_ballot, percentage: 1-percentage, simulation: simulation)
          end

          context 'when there are no newer ballots' do
            it 'uses all ballots for calculation' do
              expect(ballot.create_partial.percentage).to eq(0.5)
            end
          end

          context 'when there are newer ballots for the same simulation' do
            let(:newer_ballot) do
              create(:simulation_ballot, percentage: 0, simulation: ballot.simulation)
            end

            it 'uses only old ballots for calculation' do
              expect(ballot.create_partial.percentage).to eq(0.5)
            end
          end
        end

        context 'for other simulation' do
          let!(:older_ballot) do
            create(:simulation_ballot, percentage: 1-percentage)
          end

          it 'ignores other simulation ballots' do
            expect(ballot.create_partial.percentage).to eq(percentage)
          end
        end
      end
    end

    context 'when there is a partial for the ballot' do
      subject!(:ballot) do
        create(:simulation_ballot, :with_partial)
      end

      it do
        expect do
          ballot.create_partial
        end.not_to change(Simulation::Ballot, :count)
      end

      it do
        expect do
          ballot.create_partial
        end.not_to change(ballot, :partial)
      end

      it do
        expect(ballot.create_partial).to be_a(Simulation::Partial)
      end
    end
  end
end
