Rails.application.routes.draw do
  root to: "users#show"
  
  devise_for :users
  
  shallow do
    resources :users do
      resources :profiles
      
      resources :mazes do
        resources :rooms do
          resources :hallways
        end
      end
    end
  end
end
