Rails.application.routes.draw do
  get 'sessions/new'
  get 'element/new'
  get 'element/create'
  post 'element/new', to: 'element#create'
  get 'element/update'
  root 'top#index'
  get 'user_profile/home'
  get 'user_profile/help'
  get '/signup',  to: 'user_profile#new'
  post '/signup', to: 'user_profile#create',:as => 'user'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :user_profile
  resources :element
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
