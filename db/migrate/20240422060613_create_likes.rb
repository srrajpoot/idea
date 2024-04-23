class CreateLikes < ActiveRecord::Migration[6.0] # Adjust the version number as per your Rails version
  def change
    create_table :likes do |t|
      t.integer :like_by_id
      t.string :likeable_type, null: false
      t.bigint :likeable_id, null: false
      t.timestamps null: false
    end
    add_index :likes, [:likeable_type, :likeable_id]
  end
end
