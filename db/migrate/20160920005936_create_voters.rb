class CreateVoters < ActiveRecord::Migration[5.0]
  def change
    create_table :voters do |t|
      t.string :uuid
      t.string :vote

      t.timestamps
    end
  end
end
