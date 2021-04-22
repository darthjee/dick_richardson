FactoryBot.define do
  factory :voting_partial, class: Voting::Partial do
    voting
    votes 100
  end
end
