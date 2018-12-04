Rails.application.routes.draw do
  root 'top#index'
  get '/help', to:'user_profile#help'
  get '/user_profile/:account/elements_edit', to: 'element#edit'
  patch '/user_profile/:account/elements_update', to: 'element#update'
  get '/signup',  to: 'user_profile#new'
  post '/signup', to: 'user_profile#create',:as => 'user'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get '/user_profile/:account/common_elements', to: 'common_elements#show'
  resources :user_profile , param: :account do
    member do
      get :friends, :follow_requests
    end
  end
  resources :element, param: :account
  resources :common_elements, param: :account
  resources :relationships, only: [:create, :destroy], param: :account
  get '*not_found' => 'application#routing_error'
  post '*not_found' => 'application#routing_error'
# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
