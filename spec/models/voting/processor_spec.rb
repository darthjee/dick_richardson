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

      it 'creates the candidates partials' do
        expect do
          processor.process
        end.to change(voting, :final_result).from(nil)
      end

      it 'records the votes for each candidate' do
        processor.process
        expect(voting.final_result.pluck(:votes)).to eq([57797423, 47040574])
      end

      it 'records the raw result' do
        processor.process
        expect(voting.partials.last.raw).to eq(request_result)
      end

      it 'sets the full votes' do
        processor.process
        expect(voting.partials.last.votes).to eq(147303938)
      end
    end

    context 'when there was a partial created before' do
      let!(:candidate1) { create(:voting_candidate, name: 'FERNANDO HADDAD', voting: voting) }
      let!(:candidate2) { create(:voting_candidate, name: 'JAIR BOLSONARO', voting: voting) }
      let(:partial_raw) { load_fixture_file('voting/raw_first.json') }
      let(:partial)     { create(:voting_partial, raw: partial_raw, voting: voting) }

      before do
        voting.candidates.each do |candidate|
          partial.candidates.create(candidate: candidate, votes: 50)
        end
      end

      it 'does not create candidates' do
        expect do
          processor.process
        end.not_to change { voting.candidates.count }
      end

      it 'creates a new partial' do
        expect do
          processor.process
        end.to change { voting.partials.count }.by(1)
      end

      it 'creates new candidates partials' do
        expect do
          processor.process
        end.to change { voting.final_result.pluck(:id) }
      end
    end
  end
end
