module SystemSpecHelpers
  # ログインフォームにユーザの値を直接入れてログインするsystem spec用ヘルパーです
  def log_in_with(user)
    visit login_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password

    click_on 'ログイン'
    expect(page).to have_current_path tops_path
  end
end
