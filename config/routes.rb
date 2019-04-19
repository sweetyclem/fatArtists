Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  authenticate :user do
    resources :profiles, only: [:new, :create, :edit]
  end
  resources :profiles, only: [:index, :show]
  root to: "profiles#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
