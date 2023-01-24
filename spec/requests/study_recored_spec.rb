require 'rails_helper'

RSpec.describe StudyRecordsController, type: :request do
    describe 'GET #new' do
      context "ログインしていない場合" do
        before do
          get new_study_record_path
        end

        it 'ステータス302が返ること' do
          expect(response.status).to eq 302
        end

        it 'ルートにリダイレクトされること' do
          expect(response).to redirect_to('/')
        end

      end
    end
      
      context "ログインしている場合" do
        let!(:user) { create(:user) }
        before do
          log_in(user)
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
      let!(:user) { create(:user) }
      before do
        log_in(user)
      end

      context "正常に登録が完了した時" do
        it "ステータス302が返ること" do
          # ユーザー情報はセッションから取得するのでここでは紐付ける教科のみ作成
          @subject = create(:subject, name: 'test')
          post study_records_path params: {
              study_record: {subject_id: @subject.id, study_date: "2023/01/01", study_time: "01:01"  }
            }
          expect(response.status).to eq 302
        end
      end

      context "登録項目に不備がある場合" do
        it "ステータス422が返ること" do
            post study_records_path params: {
                study_record: {subject_id: nil, study_date: "2023/01/01", study_time: "00:00" }
            }
            expect(response.status).to eq 422
            expect(response.body).to include 'The form contains 2 errors.'
            expect(response.body).to include 'Subject must exist'
            expect(response.body).to include 'Study time must be greater than 0'
        end
        
      end
    end

    describe 'POST #destroy' do
      let!(:user) { create(:user) }
      let!(:study_record) { create(:study_record, user: user) }

      before do
        log_in(user)
      end

      context '正常系' do
        it '学習記録が削除される' do
          delete study_record_path(study_record)

          expect(flash).to be_any
          expect(flash[:success]).to eq "学習記録を削除しました。"
          expect(response.status).to eq 303
          expect(response).to redirect_to('/tops')

          # レコードが削除される
          expect(StudyRecord.find_by(id: study_record.id)).to eq nil
        end
      end

      context '異常系(不正なパラメータ)' do
        it 'エラーが発生した旨のメッセージが返る' do
          delete study_record_path(-1) # 不正なパラメータ

          expect(flash).to be_any
          expect(flash[:warning]).to eq "削除時にエラーが発生しました"
          expect(response.status).to eq 303
          expect(response).to redirect_to('/tops')

          expect(StudyRecord.find_by(id: study_record.id)).to eq study_record
        end
      end
    end
end
