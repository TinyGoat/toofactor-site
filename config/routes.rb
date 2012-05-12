Toofactor::Application.routes.draw do

  devise_for :users

  get '/contact' => 'contact#index', as: :contact_us
  get '/terms' => 'home#terms_of_service', as: :terms
  get "plans", to: "plans#index", as: :plans
  get "contact", to: "contact#index", as: :contact

  post '/contact' => 'contact#contact', as: :make_contact
  root :to => 'home#index'
end
