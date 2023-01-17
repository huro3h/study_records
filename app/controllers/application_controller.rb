class ApplicationController < ActionController::Base
    include SessionsHelper
    
    private
    # ユーザーのログインを確認する
    def logged_in_user
      unless logged_in?
        flash[:danger] = "ログインして下さい"
        redirect_to root_path
      end
    end

end
