class Login < ApplicationRecord
	self.table_name = :logins
	validates :password, presence: true, on: :create


end
