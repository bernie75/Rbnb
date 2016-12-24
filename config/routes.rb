Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  mount Attachinary::Engine => "/attachinary"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :flats do
    resources :reviews, only: [:new, :create]
    collection do
      get 'top', to: "flats#top"
    end
  end

  resources :reservations, only: [:show, :create] do
    resources :payments, only: [:new, :create]
  end
end
