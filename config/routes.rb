# frozen_string_literal: true

Rails.application.routes.draw do
  mount ActionCable.server => '/cable'

  namespace :api do
    namespace :v1 do
      resources :orders, only: [:create]
    end
  end
end
