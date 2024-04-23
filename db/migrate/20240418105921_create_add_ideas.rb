class CreateAddIdeas < ActiveRecord::Migration[7.1]
  def change
    create_table :add_ideas do |t|
      t.string :title
      t.integer :idea_type
      t.references :account, null: false, foreign_key: true

      t.timestamps
    end
  end
end
