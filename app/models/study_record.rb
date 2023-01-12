class StudyRecord < ApplicationRecord
  belongs_to :user
  belongs_to :subject

  validates :study_date, presence: true
  validates :study_time, presence: true
end