require 'rails_helper'

RSpec.describe 'tops_path', type: :system, js: true do
  describe 'ユーザTopページ' do
    it '教科マスタを登録するリンクが表示され、リンクから登録ページに正常に遷移できること' do
      visit tops_path
      expect(page).to have_link '教科を新しく登録する', href: new_subject_path

      click_link  '教科を新しく登録する'

      expect(page).to have_current_path new_subject_path
      expect(page).to have_content 'New subject'
    end

    it '今日の学習を記録するリンクが表示され、リンクから学習記録ページに正常に遷移できること' do
      visit tops_path
      expect(page).to have_link '今日の学習を記録する', href: new_study_record_path

      click_link '今日の学習を記録する'

      expect(page).to have_current_path new_study_record_path
      expect(page).to have_content '勉強時間を記録'
    end
  end

  # TODO: [CG-42]で対応。機能実装後にコメントアウトを外します
  # describe 'ユーザの学習記録' do
  #   let!(:user) { create(:user, name: 'テスト太郎') }
  #   let!(:study_record) {
  #     create(
  #       :study_record, user: user, study_date: Time.current, study_time: Time.new(2023, 1, 4, 2, 30, 0), subject: subject
  #     )
  #   }
  #   let!(:subject) { create(:subject, name: 'コラボレイティブ開発特論') }
  #
  #   let(:another_study_record) {
  #     create(:study_record, user: create(:user, name: '他人太郎'),
  #       study_date: Time.current, study_time: Time.new(2023, 1, 1, 1, 30, 0), subject: subject)
  #   }
  #
  #   it 'ユーザに紐づく学習記録が表示されていること' do
  #     # ログイン処理をここに書く
  #     visit tops_path
  #     expect(page).to have_current_path tops_path
  #
  #     expect(page).to have_content 'テスト太郎' # ユーザ名
  #     expect(page).to have_content 'コラボレイティブ開発特論' # 教科名
  #     expect(page).to have_content '2023-01-04' # 記録日
  #     expect(page).to have_content '2:30' # 学習時間
  #   end
  #
  #   it '他ユーザの学習記録は表示されないこと' do
  #     visit tops_path
  #     expect(page).to have_current_path tops_path
  #
  #     # 他ユーザの学習記録
  #     expect(page).to_not have_content '2023-01-01'
  #     expect(page).to_not have_content '1:30'
  #   end
  # end
end
