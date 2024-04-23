class Post < ApplicationRecord
  self.table_name = :posts
  belongs_to :category
  belongs_to :account
  has_many :likes, as: :likeable, dependent: :destroy

end
