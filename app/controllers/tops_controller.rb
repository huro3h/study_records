class TopsController < ApplicationController
  before_action :logged_in_user

  def index
    set_study_records
    set_study_records_for_chart
  end

  private

  def set_study_records
    user = current_user
    @study_records = user.study_records.preload(:subject).order(study_date: :desc).order(id: :desc)
  end

  def set_study_records_for_chart
    @data = current_user.study_records.grouped_by_date.sum(:study_time).map(&:to_a)
  end
end
