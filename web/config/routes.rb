Rails.application.routes.draw do
  root 'top#index'
  get 'user_profile/home'
  get 'user_profile/help'
  get 'user_profile/ryama'
  get 'user_profile/kame'
  get 'user_profile/gussy'
  get '/signup',  to: 'user_profile#new'
  post '/signup', to: 'user_profile#create',:as => 'user'
  resources :user_profile
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
