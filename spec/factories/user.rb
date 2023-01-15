FactoryBot.define do
  factory :user do
    name { Faker::Japanese::Name.name }
    sequence(:email) { |n| "#{n}_#{Faker::Internet.email}" }
  end
end
