Rails.application.routes.draw do
  devise_for :users

  resources :articles, only: [:index, :new, :show]

  namespace :api, { format: 'json'} do
    namespace :v1 do
      resources :articles
    end
  end
end
