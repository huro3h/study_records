class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user&.authenticate(params[:session][:password])
      redirect_to tops_url
    else
      flash.now[:danger] = 'ユーザーが見つかりません'
      render 'new', status: :unprocessable_entity
    end

  end

  private
    def user_params
        # parameterとして許可する属性定義
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end


end
