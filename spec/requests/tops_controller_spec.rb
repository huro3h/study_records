require 'rails_helper'

RSpec.describe TopsController, type: :request do
  describe 'GET #index' do
    let!(:user) { create(:user) }

    before do
      log_in(user)
      get tops_path
    end

    it 'ステータス200が返ること' do
      expect(response.status).to eq 200
    end
  end
end
