FactoryBot.define do
  factory :post do
    name { "MyString" }
    description { "MyText" }
    body { "MyText" }
    location { "MyString" }
    category { nil }
    account { nil }
  end
end
