Rails.application.routes.draw do
  root to: "homes#show"
  resources :recipes, only: %i(new create show edit destroy)
  resource :session, only: %i(new create destroy)
  resources :users, only: [:new, :create, :show]
end
