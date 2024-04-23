  class Feedback < ApplicationRecord
    self.table_name = :feedbacks    

    belongs_to :account
    validates :description, presence: true

  end
