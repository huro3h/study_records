class StudyRecordsController < ApplicationController
    
    def new
        @study_record = StudyRecord.new
    end

    # POST /subjects
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
            # parameterとして許可する属性
            params.require(:study_record).permit(:user_id, :subject_id, :study_date, :study_time)
        end

end