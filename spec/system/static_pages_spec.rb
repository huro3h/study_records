require 'rails_helper'

RSpec.describe 'root_path', type: :system do
  describe 'StudyRecords Topページ' do
    it 'トップページにサービス名とユーザ登録ボタンが表示されていること' do
      visit root_path
      expect(page).to have_content 'StudyRecords Topページ'
      expect(page).to have_button 'ユーザー登録'
    end
  end
end
