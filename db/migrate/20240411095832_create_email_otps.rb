class CreateEmailOtps < ActiveRecord::Migration[6.0]
  def change
    create_table :email_otps do |t|
      t.string :email
      t.integer :pin
      t.boolean :activated, default: false, null: false
      t.datetime :valid_until
    end
  end
end
