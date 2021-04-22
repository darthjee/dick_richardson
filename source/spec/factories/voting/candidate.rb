FactoryBot.define do
  factory :voting_candidate, class: Voting::Candidate do
    voting
    name { ['FERNANDO HADDAD', 'JAIR BOLSONARO'].random }
  end
end
