require 'faker'

FactoryBot.define do
  factory :user do
    email { Faker::Internet.unique.email }
    name { Faker::StarWars.character }
    password { '123456' }
    password_confirmation { '123456' }
    confirmed_at { Time.zone.now }

    trait :with_image do
      image { "iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mP8/5+hHgAHggJ/PchI7wAAAABJRU5ErkJggg==" }
    end
  end
end
