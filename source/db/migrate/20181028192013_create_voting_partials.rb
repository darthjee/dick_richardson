class CreateVotingPartials < ActiveRecord::Migration[5.2]
  def change
    create_table :voting_partials do |t|
      t.integer :voting_id, null: false
      t.text :raw, null: false
      t.integer :votes, null: false, default: 0
    end
  end
end
