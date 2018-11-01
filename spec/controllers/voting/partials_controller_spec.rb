require 'spec_helper'

describe Voting::PartialsController, type: :controller do
  let(:voting)  { create(:voting, active: active) }
  let(:active)  { true }
  let(:payload) { load_json_fixture_file('voting/tse_response_partial.json') }

  let(:parameters) do
    {
      voting_id: voting.id,
      payload: payload
    }
  end

  describe 'POST create' do
    context 'when the request happens' do
      context 'when it is a new partial result' do
        it 'creates a new partial' do
          expect do
            post :create, params: parameters
          end.to change { voting.partials.count }.by(1)
        end
      end

      context 'when there is a registered partial' do
        include_context 'voting with one partial'

        before do
          voting.candidates.each do |candidate|
            partial.candidates.create(candidate: candidate, votes: 50)
          end
        end

        context 'for the same result as the new partial' do
          let(:partial_raw)   { load_fixture_file('voting/tse_response_partial.json') }
          let(:current_votes) { 147303938 }

          it 'does not create a new partial' do
            expect do
              post :create, params: parameters
            end.not_to change { voting.partials.count }
          end
        end

        context 'for an older result' do
          it 'creates a new partial' do
            expect do
              post :create, params: parameters
            end.to change { voting.partials.count }.by(1)
          end
        end
      end

      context "when voting is inactive" do
        let(:active) { false }

        it 'does not create a new partial' do
          expect do
            post :create, params: parameters
          end.not_to change { voting.partials.count }
        end
      end
    end

    context 'after the request' do
      before do
        post :create, params: parameters
      end

      it do
        expect(response).to be_a_successful
      end
    end
  end
end
