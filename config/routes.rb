# frozen_string_literal: true

Spree::Core::Engine.routes.draw do
  namespace :admin do
    resources :gdpr_requests, only: %w[index new create destroy] do
      member do
        post :serve
      end
    end
  end

  namespace :api do
    resource :users do
      member do
        get :emails
      end
    end
  end
end
