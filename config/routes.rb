Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  authenticate :user do
    resources :profiles, only: [:new, :create, :edit]
  end
  resources :profiles, only: [:index, :show]
  authenticated :user, lambda {|u| u.admin } do
    get 'activate/:id', to: 'users#activate', as: :activate_user
    get 'inactive', to: 'users#inactive', as: :inactive_users
    get 'active', to: 'users#active', as: :active_users
    get 'destroy/:id', to: 'users#destroy', as: :destroy_user
    post 'active', to: 'users#active', as: :filter_users
  end
  post '/', to: 'profiles#index', as: :filter_profiles
  root to: "profiles#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
