class CreateLogirails < ActiveRecord::Migration[7.1]
  def change
    create_table :logirails do |t|
      t.string :generate
      t.string :controller
      t.string :Loginsn

      t.timestamps
    end
  end
end
