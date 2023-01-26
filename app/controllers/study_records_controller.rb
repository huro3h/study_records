class StudyRecordsController < ApplicationController
    before_action :logged_in_user, only: [:new, :create, :destroy]
    before_action :set_study_record, only: [:destroy]

    def new
        @study_record = StudyRecord.new
    end

    def create
        @study_record = current_user.study_records.build(study_recored_params)

        if @study_record.save
            redirect_to tops_path
        else
            render 'new', status: :unprocessable_entity
        end
    end

    def destroy
        if @study_record
            @study_record.destroy
            flash[:success] = "学習記録を削除しました。"
        else
            flash[:warning] = "削除時にエラーが発生しました"
        end

        redirect_to tops_path, status: :see_other
    end

    private
        def study_recored_params
            params[:study_record][:study_time] = convert_time_field_to_minutes(params[:study_record][:study_time])
            params.require(:study_record).permit(:user_id, :subject_id, :study_date, :study_time)
        end

        def convert_time_field_to_minutes(string)
            if string.kind_of?(String)
              string.split(":").map(&:to_i).then { |hour, minutes| hour * 60 + minutes }
            end
        end

        def set_study_record
            @study_record = current_user.study_records.find_by(id: params[:id])
        end
end
