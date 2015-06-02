Rails.application.routes.draw do
  resources :posts do
    resources :comments
    post 'vote'
  end
  resources :comments
  devise_for :admins
  devise_for :users, controllers: { registrations: "users/registrations" }   
  resources :posts
  devise_scope :user do
  get '/users' => 'users/registrations#index', as:'index_user_registration'
  get '/users/:id' => 'users/registrations#show', as:'show_user_registration'
  delete '/users/:id' => 'users/registrations#destroy', as:'delete_user_registration'
  end 
  
  root 'posts#index'
  
end
