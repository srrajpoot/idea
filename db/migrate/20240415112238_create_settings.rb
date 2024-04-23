class CreateSettings < ActiveRecord::Migration[7.1]
  def change
    create_table :settings do |t|
      t.string :title
      t.string :name

      t.timestamps
    end
  end
end
