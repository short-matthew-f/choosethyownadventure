class RatingsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :ensure_user_has_created_profile
  before_filter :ensure_user_has_finished_maze, only: [:new, :create]
  
  def new
    @maze = Maze.find(params[:maze_id])
    
    @rating = @maze.ratings.new(user: current_user)
  end
  
  def create
    @maze = Maze.find(params[:maze_id])
    
    @rating = @maze.ratings.new(rating_params)
    
    @rating.user = current_user
    
    if @rating.save
      redirect_to @maze
    else
      render :new
    end
  end
  
  def index
    @maze = Maze.find(params[:maze_id])
    
    @ratings = @maze.ratings
  end
  
  def edit 
    @rating = Rating.find(params[:id])
    @maze = @rating.maze
  end
  
  def update    
    @rating = Rating.find(params[:id])
    @maze = @rating.maze
    
    if @rating.update(rating_params)
      redirect_to @maze
    else
      render :new
    end
  end
  
  private
  
  def ensure_user_has_finished_maze
    @maze = Maze.find(params[:maze_id])
    
    unless current_user.has_finished?(@maze)
      flash[:error] = "Cannot rate a maze you haven't finished."
      redirect_to @maze
    end
  end
  
  def rating_params
    params.require(:rating).permit(:description, :stars)
  end
end
