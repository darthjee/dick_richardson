class CreateVotingPartialCandidates < ActiveRecord::Migration[5.2]
  def change
    create_table :voting_partial_candidates do |t|
      t.integer :partial_id, null: false
      t.integer :candidate_id, null: false
      t.integer :votes, null: false
    end
  end
end
