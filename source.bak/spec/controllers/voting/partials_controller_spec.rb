require 'spec_helper'

describe Voting::PartialsController, type: :controller do
  let(:base_parameters) { { voting_id: voting.id } }
  let(:parameters)      { base_parameters }
  let(:response_json)   { JSON.parse(response.body) }

  describe 'POST /create' do
    let(:voting)  { create(:voting, active: active) }
    let(:active)  { true }
    let(:payload) { load_json_fixture_file('voting/tse_response_partial.json') }

    let(:parameters) { base_parameters.merge(payload: payload) }

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

  describe 'GET /raw' do
    let(:raw)      { load_fixture_file('voting/tse_response_partial.json') }
    let(:raw_hash) { load_json_fixture_file('voting/tse_response_partial.json') }
    let(:voting)   { partial.voting }
    let!(:partial) { create(:voting_partial, raw: raw) }

    before do
      get :index_raw, params: parameters
    end

    it 'returns all raw entities' do
      expect(response_json).to eq([ raw_hash ])
    end

    it do
      expect(response).to be_a_successful
    end
  end
end
