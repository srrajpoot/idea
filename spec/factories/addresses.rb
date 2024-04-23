FactoryBot.define do
  factory :address do
    country { "MyString" }
    latitude { 1.5 }
    longitude { 1.5 }
    address { "MyString" }
    addressble_id { 1 }
    addressble_type { "MyString" }
    address_type { 1 }
  end
end
