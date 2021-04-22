class CreateVotingCandidates < ActiveRecord::Migration[5.2]
  def change
    create_table :voting_candidates do |t|
      t.integer :voting_id, null: false
      t.string :name, null: false
    end
  end
end
