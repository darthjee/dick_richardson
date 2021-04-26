class CreateSimulationBallots < ActiveRecord::Migration[5.2]
  def change
    create_table :simulation_ballots do |t|
      t.float :percentage
    end
  end
end
