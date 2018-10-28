# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
s = Simulation::Simulation.create
[0.7, 0.3, 0.52].each do |p|
  Simulation::Ballot.create(
    percentage: p, simulation: s
  ).create_partial
end
