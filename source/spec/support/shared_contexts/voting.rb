shared_context 'voting with one partial' do
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
end
