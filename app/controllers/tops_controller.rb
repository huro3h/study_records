class TopsController < ApplicationController
  def index
    set_user
    set_study_records
  end

  private

  def set_user
    # session実装後に切り替えます
    @user = User.first # User.find(params[:user_id]) # current_user
  end

  def set_study_records
    @study_records = @user.study_records.preload(:subject).order(study_date: :desc).order(id: :desc)
  end
end
