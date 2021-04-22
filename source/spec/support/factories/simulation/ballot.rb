FactoryBot.define do
  factory :simulation_ballot, class: Simulation::Ballot do
    simulation
    percentage { 0.7 }

    trait :with_partial do
      after :create do |ballot, _|
        ballot.create_partial
      end
    end
  end
end

