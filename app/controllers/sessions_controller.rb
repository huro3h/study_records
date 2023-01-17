class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user&.authenticate(params[:session][:password])
      log_in user
      redirect_to tops_url || user
    else
      flash.now[:danger] = 'ユーザーが見つかりません'
      render 'new', status: :unprocessable_entity
    end

  end

  def destroy
    log_out
    redirect_to root_path
  end

  private
    def user_params
        # parameterとして許可する属性定義
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

end
