class CategoriesController < ApplicationController
    before_action :require_login

 def index
    @user = User.find(params[:id])
    if @user == current_user
      @categories = @user.categories 
    else
      redirect_to root_path, alert: "他のユーザーのページにはアクセスできません。"
    end
 end
    
 def new
 end

 def create
 end

 def show
    @category = Category.find(params[:id])  # URLからカテゴリを取得
    @todos = @category.todos 
 end

 private

  def require_login
    unless logged_in?
      redirect_to login_path, alert: "ログインが必要です。"
    end
  end

end
