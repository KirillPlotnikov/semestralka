Rails.application.routes.draw do
  get 'settings/index'

  scope '/settings' do
    resources :tags, controller: 'settings_tags'
    resources :categories, controller: 'settings_categories'
  end

  get '/account', to: 'account#index'


  resources :tasks do
    collection do
      get 'completed'
      get 'pending'
    end
  end


  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout' }

  root 'tasks#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
