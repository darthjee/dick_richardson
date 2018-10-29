require 'spec_helper'

describe Voting::Processor do
  subject(:processor) { described_class.new(voting) }

  let(:voting) { create(:voting) }

  describe '#process' do
    let(:request_result) { load_fixture_file('voting/tse_response_partial.json') }
    let(:time_integer)   { Time.now.to_i }
    let(:request_url)    do
      "http://divulga.tse.jus.br/2018/divulgacao/oficial/296/dadosdivweb/br/br-c0001-e000296-w.js?#{time_integer}"
    end

    before do
      allow_any_instance_of(Time).to receive(:to_i).and_return(time_integer)
      stub_request(:get, request_url).to_return(status: 200, body: request_result)
    end

    context 'when there is no partial' do
      it 'creates the partial' do
        expect do
          processor.process
        end.to change { voting.partials.count }.by(1)
      end

      it 'creates the candidates' do
        expect do
          processor.process
        end.to change { voting.candidates.count }.by(2)
      end
    end
  end
end
