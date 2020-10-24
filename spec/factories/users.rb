FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    activated { true }
    admin { false }
    password { "abc" }
    password_confirmation { "abc" }
  end
end
