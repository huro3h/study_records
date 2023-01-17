require 'rails_helper'

RSpec.describe TopsController, type: :request do

  describe 'GET #index' do
    context "ログインしていない場合" do
      before do
        get tops_path
      end

      it 'ステータス302が返ること' do
        expect(response.status).to eq 302
      end

      it 'ルートにリダイレクトされログインして下さいのメッセージが表示されること' do
        expect(response).to redirect_to('/')
        # TODO できればリダイレクト先のbodyがみたい
        # expect(response.body).to include 'ログインして下さい'
      end

    end

    context "ログインしている場合" do
      let!(:user) { create(:user) }
      before do
        log_in(user)
        get tops_path
      end

      it 'ステータス200が返ること' do
        expect(response.status).to eq 200
        expect(response.body).to include 'アカウント'
      end

    end

  end

end
