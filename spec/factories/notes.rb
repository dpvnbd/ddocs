FactoryBot.define do
  factory :note do
    body { Faker::Food.description }
  end
end
