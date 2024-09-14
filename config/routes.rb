Rails.application.routes.draw do
  root "static_pages#home"
  get "/make", to: "static_pages#make"
end
