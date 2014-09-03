Rails.application.routes.draw do
  root to: "users#show"
  
  devise_for :users
  
  resources :users do
    resources :profiles, shallow: true
    resources :mazes, shallow: true
  end
end
