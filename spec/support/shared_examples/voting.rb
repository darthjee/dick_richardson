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
    partial_hash = JSON.parse(voting.partials.last.raw)
    real_hash = JSON.parse(raw)
    expect(partial_hash).to eq(real_hash)
  end
end

shared_examples 'a method call that creates candidates' do |method_name, quantity|
  it "creates the missing candidates" do
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
    end.not_to change { voting.final_result.pluck(:id) }
  end
end

shared_examples 'a method that process votes entries' do |method_name|
  let(:voting) { create(:voting) }
  let(:raw) { load_fixture_file('voting/tse_response_partial.json') }

  context 'when there is no partial' do
    it_behaves_like 'a method call that creates partial', method_name
    it_behaves_like 'a method call that creates candidates', method_name, 2

    context 'when there was a partial created before' do
      let!(:candidate1)   { create(:voting_candidate, name: 'FERNANDO HADDAD', voting: voting) }
      let!(:candidate2)   { create(:voting_candidate, name: 'JAIR BOLSONARO', voting: voting) }
      let(:partial)       { create(:voting_partial, raw: partial_raw, votes: current_votes, voting: voting) }
      let(:partial_raw)   { load_fixture_file('voting/raw_first.json') }
      let(:current_votes) { 100 }

      before do
        voting.candidates.each do |candidate|
          partial.candidates.create(candidate: candidate, votes: 50)
        end
      end

      context 'and the request returns new value' do
        it_behaves_like 'a method call that creates partial', method_name

        it 'does not create candidates' do
          expect do
            subject.public_send(method_name)
          end.not_to change { voting.candidates.count }
        end
      end

      context 'when only one candidate existed' do
        let!(:candidate2) {}

        it_behaves_like 'a method call that creates partial', method_name
        it_behaves_like 'a method call that creates candidates', method_name, 1
      end

      context 'and the request return the same old result' do
        let(:partial_raw)   { load_fixture_file('voting/tse_response_partial.json') }
        let(:current_votes) { 147303938 }

        it_behaves_like 'a method call that does not change anything', method_name
      end
    end
  end
end
