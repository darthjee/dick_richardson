class CreateSimulationPartials < ActiveRecord::Migration[5.2]
  def change
    create_table :simulation_partials do |t|
      t.float :percentage
    end
  end
end
