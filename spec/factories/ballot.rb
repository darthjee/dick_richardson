FactoryBot.define do
  factory :simulation_ballot, class: Simulation::Ballot do
    simulation
    percentage 0.7
  end
end

