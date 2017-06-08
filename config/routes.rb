require "monban/constraints/signed_in"
require "monban/constraints/signed_out"

Rails.application.routes.draw do
  constraints Monban::Constraints::SignedOut.new do
    root to: "homes#show"
  end

  constraints Monban::Constraints::SignedIn.new do
    root to: "dashboards#show"
  end

  resources :recipes, only: %i(show) do
    member do
      post "like" => "likes#create"
      post "unlike" => "likes#destroy"
    end

    member do
      post "bookmark" => "bookmarks#create"
      post "remove_bookmark" => "bookmarks#destroy"
    end

    resources :comments, only: %i(create)
  end

  resources :comments, only: %i(destroy)

  resource :session, only: %i(new create destroy)

  resources :users, only: [:new, :create, :show] do
    member do
      post "follow" => "follows#create"
      post "unfollow" => "follows#destroy"
    end
  end

  namespace :my do
    resources :recipes, only: %i(new create edit destroy update)
  end
end
