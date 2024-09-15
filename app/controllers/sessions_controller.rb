class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id  # ログイン状態を保持
      redirect_to user_home_path(user), notice: "ログインに成功しました。"
    else
      flash.now[:alert] = "メールアドレスまたはパスワードが間違っています。"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil  # ログアウト処理
    redirect_to login_path, notice: "ログアウトしました。"
  end
end
