require 'rails_helper'

RSpec.describe StaticPagesController, type: :request do
  describe 'GET #home' do
    it 'ステータス200が返ること' do
      get root_path
      expect(response.status).to eq 200
    end
  end
end
