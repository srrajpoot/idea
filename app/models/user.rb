class User < ApplicationRecord
	  has_many :likes, foreign_key: "like_by_id", dependent: :destroy
	  
end
