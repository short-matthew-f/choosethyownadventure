Rails.application.routes.draw do
  
  root to: "users#show"
  
  devise_for :users
  
  resources :mazes, only: [:index]
  
  shallow do
    resources :users do      
      resources :profiles
      
      resources :mazes, except: [:index] do
        resources :rooms do
          resources :hallways
        end
      end
    end
  end
    
end
