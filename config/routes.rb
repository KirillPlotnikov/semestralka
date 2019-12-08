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
      get 'search/:keyword', action: 'search', as: :tasks_search
      get 'by-category/:category', action: 'by_category', as: :filter_by_category
      get 'by-tags/:tags_ids', action: 'by_tags', as: :filter_by_tags
      get 'by-category/:category/by-tags/:tags_ids', action: 'by_tags', as: :filter_by_category_and_tags
    end
  end


  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout' }

  root 'tasks#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
