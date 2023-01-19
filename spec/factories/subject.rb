FactoryBot.define do
  factory :subject do
    sequence(:name) { |n| "情報アーキテクチャ特論#{n}" }
  end
end
