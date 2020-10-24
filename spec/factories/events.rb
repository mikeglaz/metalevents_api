# require 'date'

FactoryBot.define do
  factory :event do
    user { create(:user) }
    venue { create(:venue) }
    name { Faker::Music.band }
    description { Faker::Music.album }
    date { DateTime.now }
  end
end
