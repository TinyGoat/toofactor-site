Toofactor::Application.routes.draw do
  devise_for :users

  get "plans", to: "plans#index"

  root :to => 'home#index'
end
