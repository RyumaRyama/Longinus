Rails.application.routes.draw do
  get 'common_elements/show'
  # get 'element/new'
  # get 'element/create'
  # post 'element/new', to: 'element#create'
  # get 'element/update'
  root 'top#index'
  get '/user_profile/:id/elements_edit', to: 'element#edit'
  patch '/user_profile/:id/elements_update', to: 'element#update'
  get '/signup',  to: 'user_profile#new'
  post '/signup', to: 'user_profile#create',:as => 'user'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :user_profile
  resources :element
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
