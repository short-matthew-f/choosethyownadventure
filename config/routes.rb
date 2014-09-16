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
  
  get 'mazes/:maze_id/play', to: "mazes#play", as: "play_maze"
  get 'mazes/:maze_id/play/:room_id', to: "mazes#move_to_room", as: "move_to_room"
end
