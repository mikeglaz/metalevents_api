# require 'date'

FactoryBot.define do
  factory :event do
    user { create(:user) }
    venue { create(:venue) }
    name { Faker::Music.band }
    description { "Covid World Tour 2020" }
    date { DateTime.now }
  end
end
