require 'rails_helper'

RSpec.describe 'subjects_path', type: :system, js: true do
  describe '科目一覧ページ' do
    let!(:user) { create(:user) }
    #表示用のテストデータ
    let!(:subject) { create(:subject, name: 'コラボレイティブ開発特論') }
    
    context "ログインしている場合" do
      before do
        # ログインフォームよりログイン
        log_in_with(user)
      end

      it '科目一覧が表示され、科目を追加するページに正常に遷移できること' do
        visit subjects_path
        expect(page).to have_current_path subjects_path
        #expect(page).to have_content 'コラボレイティブ開発特論'
        expect(page).to have_link href: new_subject_path
        click_on '科目を追加する'
      end
    end
  end

  describe '科目登録ページ' do
    let!(:user) { create(:user) }

    context "ログインしている場合" do
      before do
        # ログインフォームよりログイン
        log_in_with(user)
      end

      it '科目登録ページに科目名が表示され、新規登録ページと科目一覧ページに正常に遷移できること' do
        visit new_subject_path
        expect(page).to have_current_path new_subject_path
        expect(page).to have_content '科目名'
        expect(page).to have_link href: subjects_path
        click_on '科目一覧に戻る'
      end
    end
  end
end