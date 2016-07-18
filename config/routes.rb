Rails.application.routes.draw do
  devise_for :users

  resources :users

  root 'users#test'

  resources :questions
  resources :businesses
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
