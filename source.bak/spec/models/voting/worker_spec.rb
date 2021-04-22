require 'spec_helper'

describe Voting::Worker do
  subject(:worker) { described_class.new(voting) }

  describe '#perform' do
    let(:time_integer)   { Time.now.to_i }

    let(:request_url) do
      "http://divulga.tse.jus.br/2018/divulgacao/oficial/296/dadosdivweb/br/br-c0001-e000296-w.js?#{time_integer}"
    end

    before do
      allow_any_instance_of(Time).to receive(:to_i).and_return(time_integer)
      stub_request(:get, request_url).to_return(status: 200, body: raw)
    end

    it_behaves_like "a method that process votes entries", :perform
  end
end

