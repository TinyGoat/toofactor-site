Toofactor::Application.routes.draw do
  get "contact/index"

  devise_for :users

  get "plans", to: "plans#index"
  get "contact", to: "contact#index"

  root :to => 'home#index'
end
