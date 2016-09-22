class RenameVotersToVotes < ActiveRecord::Migration[5.0]
  def change
      rename_table :voters, :votes
  end
end
