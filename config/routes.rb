require "monban/constraints/signed_in"
require "monban/constraints/signed_out"
require "resque/server"

Rails.application.routes.draw do
  constraints Monban::Constraints::SignedOut.new do
    root to: "homes#show"
  end

  constraints Monban::Constraints::SignedIn.new do
    root to: "dashboards#show"
  end

  constraints ->(_request) { Rails.env.development? } do
    mount Resque::Server, at: '/jobs'
  end

  resource :search, only: %i(show)

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

  resources :users, only: [:new, :create, :show, :update] do
    member do
      post "follow" => "follows#create"
      post "unfollow" => "follows#destroy"
    end
  end

  namespace :my do
    resources :recipes, only: %i(new create edit destroy update)
  end

  namespace :api do
    namespace :v1 do
      resources :users, only: %i(create)
      resource :session, only: %i(create)
      resources :recipes, only: %i(index create) do
        member do
          post "like" => "likes#create"
          post "unlike" => "likes#destroy"
        end

        resources :comments, only: %i(create)

        member do
          post "bookmark" => "bookmarks#create"
          post "remove_bookmark" => "bookmarks#destroy"
        end
      end
      resource :search, only: %i(show)
      resources :comments, only: %i(destroy)
    end
  end
end
