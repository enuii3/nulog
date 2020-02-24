Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get 'sample_page', to: 'samples#page'
  get 'sample_api', to: 'samples#api'
end
