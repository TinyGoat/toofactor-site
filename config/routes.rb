Toofactor::Application.routes.draw do
  get '/contact' => 'contact#index', as: :contact_us
  post '/contact' => 'contact#contact', as: :make_contact
  root :to => 'home#index'
end
