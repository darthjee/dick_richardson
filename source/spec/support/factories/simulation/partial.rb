FactoryBot.define do
  factory :simulation_partial, class: Simulation::Partial do
    ballot { create :simulation_ballot }
    percentage { 0.7 }
  end
end
