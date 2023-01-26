require 'rails_helper'

RSpec.describe 'tops_path', type: :system, js: true do
  describe 'ユーザTopページ' do

    context "ログインしている場合" do
      let!(:user) { create(:user) }

      before do
        visit root_path
        # ログインフォームよりログイン
        log_in_with(user)
      end

      it '教科マスタを登録するリンクが表示され、リンクから登録ページに正常に遷移できること' do
        expect(page).to have_link '教科を新しく登録する', href: new_subject_path

        click_link  '教科を新しく登録する'

        expect(page).to have_current_path new_subject_path
        expect(page).to have_content '科目を追加する'
      end

      it '今日の学習を記録するリンクが表示され、リンクから学習記録ページに正常に遷移できること' do
        expect(page).to have_link '今日の学習を記録する', href: new_study_record_path

        click_link '今日の学習を記録する'

        expect(page).to have_current_path new_study_record_path
        expect(page).to have_content '勉強時間を記録'
      end

    end
  end

  describe 'ユーザの学習記録' do
    let!(:subject) { create(:subject, name: 'コラボレイティブ開発特論') } # 画面に表示される教科名のデータ

    # ログインするユーザとTopページに表示される学習記録のテスト用データを作成
    let!(:user) { create(:user, name: 'テスト太郎') } # ログインするユーザのデータ
    let!(:study_record) {
      create(:study_record, user: user, subject: subject, study_date: Time.new(2023, 1, 16), study_time: 120)
    }

    # 他ユーザの学習記録。ログインしているユーザ以外の学習記録は、ユーザTopページに表示されないことを確認する為にデータを作っています
    let!(:another_user) { create(:user, name: '他人太郎') }
    let!(:another_study_record) {
      create(:study_record, user: another_user, subject: subject, study_date: Time.new(2023, 1, 11), study_time: 1000)
    }

    before do
      log_in_with(user)
    end

    it 'ユーザに紐づく学習記録がTopページに表示されていること' do
      expect(page).to have_current_path tops_path

      expect(page).to have_content 'テスト太郎' # ユーザ名
      expect(page).to have_content 'コラボレイティブ開発特論' # 教科名
      expect(page).to have_content '2023-01-16' # 記録日
      expect(page).to have_content '120' # 学習時間
    end

    it '他ユーザの学習記録は表示されないこと' do
      expect(page).to have_current_path tops_path

      # 他ユーザの学習記録
      expect(page).to_not have_content '2023-01-11'
      expect(page).to_not have_content 1000
    end
  end

  describe '学習記録の削除' do
    let!(:subject) { create(:subject, name: 'コラボレイティブ開発特論') }
    let!(:user) { create(:user) }
    let!(:study_record) {
      create(:study_record, user: user, subject: subject)
    }

    before do
      log_in_with(user)
    end

    it '削除ボタンで学習記録を削除することができる' do
      expect(page).to have_current_path tops_path

      expect(page).to have_content 'コラボレイティブ開発特論'
      click_on '削除'

      # JavaScriptのalertで表示される確認ダイアログ。accept_confirmでOKをクリックする
      expect(page.accept_confirm).to include '本当に削除してよろしいですか?'
      expect(page).to have_content '学習記録を削除しました。'

      expect(page).to_not have_content 'コラボレイティブ開発特論'
    end
  end
end
