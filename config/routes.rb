Rails.application.routes.draw do
  resources :hallways

  root to: "users#show"
  
  devise_for :users
  
  shallow do
    resources :users do
      resources :profiles
      
      resources :mazes do
        resources :rooms
      end
    end
  end
end
