class Like < ApplicationRecord
  self.table_name = :likes
  belongs_to :like_by, class_name: "User", foreign_key: "like_by_id"
  belongs_to :likeable, polymorphic: true
  belongs_to :post  
end


