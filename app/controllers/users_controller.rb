class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id  # 登録後、自動的にログインさせる
      redirect_to root_path, notice: "サインアップに成功しました！"
    else
      render :new
    end
  end

    private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
