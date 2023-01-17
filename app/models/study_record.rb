# == Schema Information
#
# Table name: study_records
#
#  id         :bigint           not null, primary key
#  study_date :datetime         not null
#  study_time :integer          not null
#  user_id    :bigint           not null
#  subject_id :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_study_records_on_subject_id  (subject_id)
#  index_study_records_on_user_id     (user_id)
#
class StudyRecord < ApplicationRecord
  belongs_to :user
  belongs_to :subject

  validates :study_date, presence: true
  validates :study_time, presence: true, numericality: {only_integer: true, greater_than: 0}
end
