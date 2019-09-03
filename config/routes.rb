# frozen_string_literal: true

Spree::Core::Engine.routes.draw do
  namespace :admin do
    resources :gdpr_requests, only: %w[index new create] do
      member do
        post :serve
      end
    end
  end
end
