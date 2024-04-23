class CreatePosts < ActiveRecord::Migration[7.1]
  def change
    create_table :posts do |t|
      t.string :name
      t.text :description
      t.text :body
      t.string :location
      t.references :account, null: false, foreign_key: true

      t.timestamps
    end
  end
end
