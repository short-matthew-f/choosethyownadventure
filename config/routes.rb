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
    
  get 'rooms/:id/move_start', to: "rooms#move_start", as: "move_start"
end
