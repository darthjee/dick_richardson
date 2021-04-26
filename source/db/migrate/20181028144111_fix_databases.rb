class FixDatabases < ActiveRecord::Migration[5.2]
  def change
    change_table :simulation_ballots do |t|
      t.change :percentage, :float, null: false
      t.integer :simulation_id, null: false
    end
    change_table :simulation_partials do |t|
      t.change :percentage, :float, null: false
      t.integer :ballot_id, null: false
    end
  end
end
