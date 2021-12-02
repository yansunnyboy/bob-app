Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :products do
    member do
      post 'toggle_category'
      post 'toggle_business'
      post 'toggle_cost'
    end
  end
  resources :lists do
    resources :solutions, only: %i[new create]
    resources :contributors, only: %i[index]
  end
  resources :solutions, only: :destroy
end
