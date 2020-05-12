Rails.application.routes.draw do
  devise_for :users

  resources :articles, only: [:index, :new, :show]

  namespace :api, { format: 'json'} do
    namespace :v1 do
      resources :articles
      resources :comments, only: :create
    end
  end
end
