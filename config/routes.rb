Rails.application.routes.draw do
  root to: "homes#show"
  resources :recipes, only: %i(show)
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
