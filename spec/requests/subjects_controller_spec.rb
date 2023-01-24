require 'rails_helper'

RSpec.describe SubjectsController, type: :request do
    
    #科目登録画面
    describe 'GET #new' do
        context "ログインしていない場合" do
            before do
                get tops_path
            end

            it 'ステータス302が返ること' do
                expect(response.status).to eq 302
            end
        end
        context "ログインしている場合" do
            #ログイン状態用のユーザー
            let!(:user) { create(:user) }
            before do
                log_in(user)
                get new_subject_path
            end

            it 'ステータス200が返ること' do
                expect(response.status).to eq 200
            end
        end
    end

    #科目一覧
    describe 'GET #index' do
        context "ログインしていない場合" do
            before do
                get tops_path
            end

            it 'ステータス302が返ること' do
                expect(response.status).to eq 302
            end
        end
        context "ログインしている場合" do
            let!(:user) { create(:user) }
            before do
              log_in(user)
              get subjects_path
            end

            it 'ステータス200が返ること' do
                expect(response.status).to eq 200
            end
        end
    end

    #科目登録時
    describe "POST #create" do
        let!(:user) { create(:user) }
        #テストデータ
        let!(:subject) { create(:subject, name: 'コラボレイティブ開発特論') }
        before do
          log_in(user)
          get new_subject_path
        end

        context "正常に登録できた場合" do
            it "ステータス302が返ること" do
                post subjects_path params: { subject: { name: 'テスト' } }
                expect(response.status).to eq 302
            end
        end

        context "登録に異常があった場合" do
            it "ステータス422が返ること" do
                post subjects_path params: { subject: { name: 'コラボレイティブ開発特論' } }
                expect(response.status).to eq 422
                expect(response.body).to include 'The form contains 1 error.'
            end
        end
    end

    #科目登録後 

end