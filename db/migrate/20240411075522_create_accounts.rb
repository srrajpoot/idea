class CreateAccounts < ActiveRecord::Migration[7.1]
  def change
    create_table :accounts do |t|
      t.string :first_name
      t.string :last_name
      t.string :full_phone_number
      t.integer :country_code
      t.bigint :phone_number
      t.string :email
      t.boolean :activated
      t.string :device_id
      t.text :unique_auth_id
      t.string :password_digest
      t.string :type
      t.string :user_name
      t.string :platform
      t.string :user_type
      t.integer :app_language_id
      t.datetime :last_visit_at
      t.boolean :is_blacklisted
      t.date :suspend_until
      t.integer :status
      t.string :stripe_id
      t.string :stripe_subscription_id
      t.datetime :stripe_subscription_date
      t.integer :role_id
      t.string :full_name
      t.integer :gender
      t.date :date_of_birth
      t.integer :age
      t.boolean :is_paid
      t.string :middle_name
      t.string :city
      t.string :country
      t.text :background
      t.string :uid
      t.string :day
      t.string :month
      t.string :year

      t.timestamps
    end
  end
end
