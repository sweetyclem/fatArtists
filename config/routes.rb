Rails.application.routes.draw do
  devise_for :users
  resources :profiles, only: [:index, :new, :create, :show, :edit]
  root to: "profiles#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
