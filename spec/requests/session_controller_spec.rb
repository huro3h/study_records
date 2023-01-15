require 'rails_helper'

RSpec.describe SessionsController, type: :request do
    describe 'GET /login' do
      before do
        get login_path
      end

      it 'ステータス200が返ること' do
        expect(response.status).to eq 200
      end

      it 'Emailとパスワード入力画面が表示されること' do
        expect(response.body).to include 'Email'
        expect(response.body).to include 'Password'
      end
  end

  describe "POST #create" do
    context "正常にログインができた時" do
      
      before do
        @user = create(:user, name: 'test', email: "test@example.com", password: '123456')
        post login_path params: {
          session: { email: "test@example.com", password: '123456' }
        }
      end
      
      it "ステータス302が返ること" do
        expect(response.status).to eq 302
      end

      it 'TOPページにリダイレクトすること' do
        expect(response).to redirect_to('/tops')
      end

    end
  end

  describe "ログインに失敗した場合" do
    context "ユーザーが見つからない場合" do
      it "ステータス422が返ること" do
        post login_path params: {
          session: { email: "test@example.com", password: '123456' }
        }
        expect(response.status).to eq 422
      end
    end
  end
  

end
