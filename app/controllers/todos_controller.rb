class TodosController < ApplicationController
  before_action :require_login

  def index
    @category = Category.find(params[:category_id]) 
    @todos = @category.todos.where(user: current_user)
  end

  def create
    @category = Category.find(params[:category_id])
    @todo = @category.todos.build(todo_params)  # カテゴリに紐づけてTodoを作成
    @todo.status = "未完了"  # デフォルトのステータスを「未完了」に設定

    if @todo.save
      redirect_to category_path(@category), notice: "Todoが追加されました。"
    else
      redirect_to category_path(@category), alert: "Todoの追加に失敗しました。"
    end
  end

  def update
    @category = Category.find(params[:category_id])
    @todo = @category.todos.find(params[:id])

    if @todo.update(todo_params)
      redirect_to category_path(@category), notice: "Todoが更新されました。"
    else
      redirect_to category_path(@category), alert: "Todoの更新に失敗しました。"
    end
  end

  def destroy
    @category = Category.find(params[:category_id])
    @todo = @category.todos.find(params[:id])
    @todo.destroy
    redirect_to category_path(@category), notice: "Todoが削除されました。"
  end


  private

  def require_login
    unless logged_in?
      redirect_to login_path, alert: "ログインが必要です。"
    end
  end

  def todo_params
    params.require(:todo).permit(:name, :status, :deadline)  # フォームからTodo名と期限を受け取る
  end
end
