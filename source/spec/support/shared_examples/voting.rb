shared_examples 'a method call that creates partial' do |method_name|
  it 'creates the partial' do
    expect do
      subject.public_send(method_name)
    end.to change { voting.partials.count }.by(1)
  end

  it 'creates the candidates partials' do
    expect do
      subject.public_send(method_name)
    end.to change {
      voting.candidates.map(&:partials).map(&:count).sum
    }.by(2)
  end

  it 'records the votes for each candidate' do
    subject.public_send(method_name)
    expect(voting.final_result.pluck(:votes)).to eq([57797423, 47040574])
  end

  it 'sets the full votes' do
    subject.public_send(method_name)
    expect(voting.partials.last.votes).to eq(147303938)
  end

  it 'records the raw result' do
    subject.public_send(method_name)
    expect(voting.partials.last.raw).to be_json_like(raw)
  end
end

shared_examples 'a method call that creates candidates' do |method_name, quantity|
  it 'creates the missing candidates' do
    expect do
      subject.public_send(method_name)
    end.to change { voting.candidates.count }.by(quantity)
  end
end

shared_examples 'a method call that does not change anything' do |method_name|
  it 'does not create candidates' do
    expect do
      subject.public_send(method_name)
    end.not_to change { voting.candidates.count }
  end

  it 'does not creates a new partial' do
    expect do
      subject.public_send(method_name)
    end.not_to change { voting.partials.count }
  end

  it 'does not create new candidates partials' do
    expect do
      subject.public_send(method_name)
    end.not_to change { voting.final_result&.pluck(:id) }
  end
end

shared_examples 'a method that process votes entries' do |method_name|
  let(:voting) { create(:voting, active: active) }
  let(:raw)    { load_fixture_file('voting/tse_response_partial.json') }
  let(:active) { true }

  context 'when there is no partial registered' do
    it_behaves_like 'a method call that creates partial', method_name
    it_behaves_like 'a method call that creates candidates', method_name, 2

    context 'but the voting is inactive' do
      let(:active) { false }

      it_behaves_like 'a method call that does not change anything', method_name
    end
  end

  context 'when there was a partial created before' do
    include_context 'voting with one partial'

    context 'and the request returns new value' do
      it_behaves_like 'a method call that creates partial', method_name

      it 'does not create candidates' do
        expect do
          subject.public_send(method_name)
        end.not_to change { voting.candidates.count }
      end

      context 'but the voting is inactive' do
        let(:active) { false }

        it_behaves_like 'a method call that does not change anything', method_name
      end
    end

    context 'when only one candidate existed' do
      let!(:candidate2) {}

      it_behaves_like 'a method call that creates partial', method_name
      it_behaves_like 'a method call that creates candidates', method_name, 1

      context 'but the voting is inactive' do
        let(:active) { false }

        it_behaves_like 'a method call that does not change anything', method_name
      end
    end

    context 'and the request return the same old result' do
      let(:partial_raw)   { load_fixture_file('voting/tse_response_partial.json') }
      let(:current_votes) { 147303938 }

      it_behaves_like 'a method call that does not change anything', method_name
    end
  end
end
