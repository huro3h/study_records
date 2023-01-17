FactoryBot.define do
  factory :user do
    name { Faker::Japanese::Name.name }
    sequence(:email) { |n| "#{n}_#{Faker::Internet.email}" }
    password { "123456" }
    password_confirmation { "123456" }
  end
end
