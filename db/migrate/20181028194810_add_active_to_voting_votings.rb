class AddActiveToVotingVotings < ActiveRecord::Migration[5.2]
  def change
    add_column :voting_votings, :active, :boolean, default: false
  end
end
