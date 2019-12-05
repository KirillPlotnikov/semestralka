Rails.application.routes.draw do
  get 'settings/index'

  resources :tags
  resources :categories
  get '/account', to: 'account#index'


  resources :tasks


  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout' }

  root 'tasks#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
