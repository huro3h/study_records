require 'rails_helper'

RSpec.describe 'root_path', type: :system, js: true do
  describe 'ユーザTopページ' do
    it '教科マスタを登録するリンクが表示されていること' do
      visit tops_path
      expect(page).to have_link '教科を新しく登録する', href: new_subject_path
    end

    # TODO: リンク作成後に修正
    # it '今日の学習を記録するリンクが表示されていること' do
    #   visit tops_path
    #   expect(page).to have_link '今日の学習を記録する', href: new_subject_path
    # end
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
  #   it 'ユーザに紐づく学習記録が表示されていること' do
  #     # ログイン処理をここに書く
  #     visit tops_path
  #
  #     expect(page).to have_content 'テスト太郎' # ユーザ名
  #     expect(page).to have_content 'コラボレイティブ開発特論' # 教科名
  #     expect(page).to have_content '2023-01-04' # 記録日
  #     expect(page).to have_content '2:30' # 学習時間
  #   end
  # end
end
