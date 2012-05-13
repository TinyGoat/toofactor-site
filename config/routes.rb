Toofactor::Application.routes.draw do

  get '/contact', to: 'contact#index',
                  as: :contact_us
  post '/contact', to: 'contact#contact',
                   as: :make_contact
  
  resources :plans, only: [:index]

  devise_for :users, controllers: { registrations: 'registrations' } do
    get '/sign_up', to: 'registrations#new', as: :sign_up
    post '/sign_up', to: 'registrations#create', as: :registration
    get '/account', to: 'registrations#edit', as: :edit_account
    get '/account/subscription', to: 'subscriptions#edit', as: :edit_subscription
    put '/account/subscription', to: 'subscriptions#update', as: :update_subscription
  end

  root :to => 'home#index'
end
