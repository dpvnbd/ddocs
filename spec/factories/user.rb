require 'faker'

FactoryBot.define do
  factory :user do
    email { Faker::Internet.unique.email }
    password { '123456' }
    password_confirmation { '123456' }
    confirmed_at { Time.zone.now }
  end
end