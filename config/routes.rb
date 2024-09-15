Rails.application.routes.draw do
  get 'todos/index'
  root "sessions#new"

  get "login", to: "sessions#new"     
  post "login", to: "sessions#create"  
  delete "logout", to: "sessions#destroy" 

  get "signup", to: "users#new"
  post "signup", to: "users#create"

  get "users/:id/home", to: "categories#index", as: "user_home"

  resources :categories, only: [:index, :new, :create, :show] do
    resources :todos, only: [:index] 
  end
end 
