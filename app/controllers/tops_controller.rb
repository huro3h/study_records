class TopsController < ApplicationController
  before_action :logged_in_user

  def index
    set_study_records
  end

  private

  def set_study_records
    user = current_user
    @study_records = user.study_records.preload(:subject).order(study_date: :desc).order(id: :desc)
  end
end
