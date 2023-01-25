require 'rails_helper'

RSpec.describe 'root_path', type: :system, js: true do
  describe 'StudyRecords Topページ' do
    let!(:user) { create(:user) }

    context "ログインしていない場合" do

      it 'ログインページより正常にログインできること' do
        visit root_path

        # ログイン前ページ
        expect(page).to have_content 'StudyRecords'
        expect(page).to have_button 'ユーザー登録'
        expect(page).to have_button 'ログインページ'

        # ログインフォームよりログイン
        log_in_with(user)

        # ログイン後ページ
        expect(page).to have_content 'StudyRecords'
        expect(page).to have_current_path tops_path
        expect(page).to have_content user.name
      end
    end

    # context "ログインしている場合" do
    #   it 'topsページにリダイレクトされること' do
    #     # TODO
    #     # リダイレクトの検証方法が分からない
    #   end
    # end

  end
end
