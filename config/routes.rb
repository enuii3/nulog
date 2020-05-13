Rails.application.routes.draw do
  root 'articles#index'

  devise_for :users, :controllers => {
    :sessions => 'users/sessions'
  }

  devise_scope :user do
    get 'sign_in', to: 'users/sessions#new'
    get 'sign_out', to: 'users/sessions#destroy'
  end

  resources :articles, only: [:index, :new, :show]

  namespace :api, { format: 'json'} do
    namespace :v1 do
      resources :articles
      resources :comments, only: :create
    end
  end
end
