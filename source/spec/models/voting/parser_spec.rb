require 'spec_helper'

describe Voting::Parser do
  let(:hash) { load_json_fixture_file('voting/tse_response_partial.json') }
  let(:raw)  { load_fixture_file('voting/tse_response_partial.json') }

  describe '#votes' do
    context 'when defining with a Hash' do
      subject(:parser) { described_class.new(hash: hash) }

      it 'votes' do
        expect(parser.votes).to eq(147303938)
      end
    end

    context 'when defining with a json' do
      subject(:parser) { described_class.new(raw: raw) }

      it 'votes' do
        expect(parser.votes).to eq(147303938)
      end
    end
  end

  describe '#candidates' do
    context 'when defining with a Hash' do
      subject(:parser) { described_class.new(hash: hash) }

      it do
        expect(parser.candidates).to be_a(Array)
      end

      it 'returns candidates' do
        expect(parser.candidates.last).to be_a(Voting::Parser::Candidate)
        expect(parser.candidates.last.name).to eq('FERNANDO HADDAD')
      end
    end

    context 'when defining with a json' do
      subject(:parser) { described_class.new(raw: raw) }

      it do
        expect(parser.candidates).to be_a(Array)
      end

      it 'returns candidates' do
        expect(parser.candidates.last).to be_a(Voting::Parser::Candidate)
        expect(parser.candidates.last.name).to eq('FERNANDO HADDAD')
      end
    end
  end

  describe '#raw' do
    context 'when defining with a Hash' do
      subject(:parser) { described_class.new(hash: hash) }

      it 'returns the raw json' do
        expect(parser.raw).to be_a(String)
        expect(parser.raw).to eq(JSON.parse(raw).to_json)
      end
    end

    context 'when defining with a raw json' do
      subject(:parser) { described_class.new(raw: raw) }

      it 'returns the raw json' do
        expect(parser.raw).to eq(raw)
      end
    end
  end

  describe '#hash' do
    context 'when defining with a Hash' do
      subject(:parser) { described_class.new(hash: hash) }

      it 'returns the raw json' do
        expect(parser.hash).to eq(hash)
      end
    end

    context 'when defining with a raw json' do
      subject(:parser) { described_class.new(raw: raw) }

      it 'returns the raw json' do
        expect(parser.hash).to eq(hash)
      end
    end
  end
end
