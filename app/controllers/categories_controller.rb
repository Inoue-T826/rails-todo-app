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
    @category = Category.new
    5.times { @category.todos.build } 
 end

 def create
    @category = current_user.categories.build(category_params)
    
    if @category.save
      redirect_to user_home_path(current_user), notice: "カテゴリが作成されました。"
    else
      flash.now[:alert] = @category.errors.full_messages.join(", ")
      render :new
    end
 end

 def destroy
    @category = current_user.categories.find(params[:id])
    if @category.destroy
      redirect_to user_home_path(current_user), notice: "カテゴリが削除されました。"
    else
      redirect_to user_home_path(current_user), alert: "カテゴリの削除に失敗しました。"
    end
  end

 def show
    @category = Category.find(params[:id])  # URLからカテゴリを取得
    @todos = @category.todos 
 end

 def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
        # カテゴリの期限とTodoの期限をチェック
        if @category.todos.any? { |todo| todo.deadline > @category.deadline }
          flash[:alert] = "警告: 1つ以上のTodoの期限がカテゴリの期限より遅れています。"
        end
        redirect_to category_path(@category), notice: "カテゴリの期限が更新されました。"
      else
        # エラーが発生した際にもカテゴリ内のすべてのTodoを再取得して表示
        @todos = @category.todos
        flash.now[:alert] = @category.errors.full_messages.join(", ")
        render :show
      end
  end

 private

  def require_login
    unless logged_in?
      redirect_to login_path, alert: "ログインが必要です。"
    end
  end

  def category_params
    params.require(:category).permit(:name, :status, :deadline, todos_attributes: [:name, :deadline])
  end

end
