class TodosController < ApplicationController
  before_action :require_login

  def index
    @category = Category.find(params[:category_id]) 
    @todos = @category.todos.where(user: current_user)
  end

  private

  def require_login
    unless logged_in?
      redirect_to login_path, alert: "ログインが必要です。"
    end
  end
end
