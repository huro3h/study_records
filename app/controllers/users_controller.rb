class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # 登録完了時にユーザーをログインさせてTOPページにリダイレクト
      log_in @user
      redirect_to tops_url(@user)
    else
      render 'new', status: :unprocessable_entity
    end
  end

  private
    def user_params
      # parameterとして許可する属性
      params.require(:user).permit(:email, :name, :password, :password_confirmation)
    end
end
