class AddIdea < ApplicationRecord
  self.table_name = :add_ideas

  belongs_to :account

end
