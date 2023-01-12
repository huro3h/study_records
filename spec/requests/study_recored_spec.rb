require 'rails_helper'

RSpec.describe StudyRecordsController, type: :request do
    describe 'GET #new' do
      before do
        get new_study_record_path
      end
      
      it 'ステータス200が返ること' do
        expect(response.status).to eq 200
      end
    
      it '勉強登録ページが表示されること' do
        expect(response.body).to include '勉強時間を記録'
        expect(response.body).to include '新規登録'
      end
    end

    describe "POST #create" do
      context "正常に登録が完了した時" do
        it "ステータス302が返ること" do
          @user = create(:user, name: 'test', email: "test@example.com", password: '123456')
          @subject = create(:subject, name: 'test')
          post study_records_path params: {
              study_record: { user_id: @user.id, subject_id: @subject.id, study_date: "2023/01/01", study_time: "01:01"  }
            }
          expect(response.status).to eq 302
        end
      end

      context "登録項目に不備がある場合" do
        it "ステータス422が返ること" do
            post study_records_path params: {
                study_record: { user_id: nil, subject_id: nil, study_date: "2023/01/01", study_time: nil }
            }
            expect(response.status).to eq 422
            expect(response.body).to include 'The form contains 3 errors.'
            expect(response.body).to include 'User must exist'
            expect(response.body).to include 'Subject must exist'
            expect(response.body).to include 'Study time can&#39;t be blank'
        end
      end
    end

end