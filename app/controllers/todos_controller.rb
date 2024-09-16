class TodosController < ApplicationController
  before_action :require_login

  def index
    @category = Category.find(params[:category_id]) 
    @todos = @category.todos.where(user: current_user)
  end

  def create
    @category = Category.find(params[:category_id])
    @todo = @category.todos.build(todo_params)  
    @todo.status = "未完了"  

    if @todo.save
      if @todo.deadline > @category.deadline
        flash[:alert] = "警告: Todoの期限がカテゴリの期限より遅れています。"
      end
      redirect_to category_path(@category), notice: "Todoが追加されました。"
    else
      @todos = @category.todos
      flash.now[:alert] = @todo.errors.full_messages.join(", ")
      render "categories/show"
    end
  end

  def update
    @category = Category.find(params[:category_id])
    @todo = @category.todos.find(params[:id])

    if @todo.update(todo_params)
      if @todo.deadline > @category.deadline
        flash[:alert] = "警告: Todoの期限がカテゴリの期限より遅れています。"
      end
      redirect_to category_path(@category), notice: "Todoが更新されました。"
    else
      @todos = @category.todos
      flash.now[:alert] = @todo.errors.full_messages.join(", ")
      render "categories/show"
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
