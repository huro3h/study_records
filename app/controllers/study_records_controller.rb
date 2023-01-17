class StudyRecordsController < ApplicationController
    before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
    
    def new
        @study_record = StudyRecord.new
    end

    def create

        @study_record = StudyRecord.new(study_recored_params)
        if @study_record.save
            redirect_to tops_path
        else
            render 'new', status: :unprocessable_entity
        end
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
end