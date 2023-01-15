FactoryBot.define do
  factory :favorite do
    user { create(:user) }
    follower { create(:user) }
  end
end
