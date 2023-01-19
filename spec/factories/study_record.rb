FactoryBot.define do
  factory :study_record do
    association :user, factory: :user
    association :subject, factory: :subject
    study_date { Time.current }
    study_time { Faker::Number.between(from: 1, to: 300) }
  end
end
