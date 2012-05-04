Toofactor::Application.routes.draw do

  get '/contact' => 'contact#index', as: :contact_us
  post '/contact' => 'contact#contact', as: :make_contact

  devise_for :users

  get "plans", to: "plans#index"
  get "contact", to: "contact#index"

  root :to => 'home#index'
end
