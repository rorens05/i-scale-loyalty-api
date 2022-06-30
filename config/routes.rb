Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  mount ActionCable.server => '/cable'

  resources :paper_trail_version do
    member do
      post :reify
    end
  end

  namespace :api do
    namespace :v1 do
      resources :orders, only: [:create]
    end
  end
end
