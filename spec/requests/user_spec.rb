require 'rails_helper'

RSpec.describe UsersController, type: :request do
  describe 'GET #new' do
    before do
      get new_user_path
    end

    it 'ステータス200が返ること' do
      expect(response.status).to eq 200
    end

    it 'Sign upページが表示されていること' do
      expect(response.body).to include 'Sign up'
      expect(response.body).to include '新規登録'
    end
  end

  describe 'POST #create' do
    context '正常に登録完了した時' do
      it 'ステータス302が返ること' do
        post users_path params: {
          user: { name: "Sample Taro", email: "sample_taro@example.com", password: 123456, password_confirmation: 123456 }
        }
        expect(response.status).to eq 302
      end
    end

    context '登録項目に不備がある時' do
      it 'ステータス422が返ること' do
        post users_path params: { user: { name: nil, password: "short", password_confirmation: "short" } }
        expect(response.status).to eq 422
        expect(response.body).to include 'The form contains 3 errors.'
        expect(response.body).to include 'Password is too short (minimum is 6 characters)'
      end
    end
  end
end
