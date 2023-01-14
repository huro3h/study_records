class StudyRecord < ApplicationRecord
  belongs_to :user
  belongs_to :subject

  validates :study_date, presence: true, comparison: { less_than_or_equal_to: Time.now }
  validates :study_time, presence: true, numericality: {only_integer: true, greater_than: 0}
end