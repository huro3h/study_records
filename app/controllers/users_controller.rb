class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user
    else
      render 'new', status: :unprocessable_entity
    end
  end

  private
    def user_params
      # parameterとして許可する属性
      params.require(:user).permit(:name, :password, :password_confirmation)
    end
end
