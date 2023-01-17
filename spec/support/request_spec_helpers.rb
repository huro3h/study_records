module RequestSpecHelpers
  # 引数で渡されたユーザの情報でログインしたことにするrequest spec用ヘルパーです
  def log_in(user)
    post login_path, params: { session: { email: user.email, password: user.password } }
  end
end
