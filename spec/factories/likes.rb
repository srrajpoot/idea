FactoryBot.define do
  factory :like do
    like_by_id { 1 }
    likeable_type { "MyString" }
    likeable_id { "" }
  end
end
