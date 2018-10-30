require 'spec_helper'

describe Voting::PartialsController, type: :controller do
  let(:voting)  { create(:voting) }
  let(:payload) { load_json_fixture_file('voting/tse_response_partial.json') }

  let(:parameters) do
    {
      voting_id: voting.id,
      payload: payload
    }
  end

  describe 'POST create' do
    context 'when the request happens' do
      it 'creates a new partial' do
        expect do
          post :create, params: parameters
        end.to change { voting.partials.count }.by(1)
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
