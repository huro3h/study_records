FactoryBot.define do
  factory :favorite do
    association :user, factory: :user
    association :follower, factory: :user
  end
end
