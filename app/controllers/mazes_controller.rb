class MazesController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @mazes = Maze.all
  end
  
  def new
    @maze = Maze.new
    @maze.rooms.build
  end
  
  def create
    @maze = Maze.new(maze_params)
    @maze.author = current_user
    
    if @maze.save
      redirect_to @maze
    else
      render :new
    end
  end
  
  def show
    @maze = Maze.find(params[:id])
  end
  
  def edit
    @maze = Maze.find(params[:id])
    
    if @maze.author == current_user
      render :edit
    else
      redirect_to @maze.author
    end
  end
  
  def update 
    @maze = Maze.find(params[:id])
    
    if @maze.update(maze_params)
      redirect_to @maze
    else
      render :edit
    end
  end
  
  def destroy
    @maze = Maze.find(params[:id])
    
    if @maze.author == current_user
      @maze.destroy
    else
      flash[:error] = "How did you do this?" 
    end
    
    redirect_to current_user
  end

  private
  
  def maze_params
    params.require(:maze).permit(
      :title, 
      :description, 
      picture_attributes: [ :image ], 
      rooms_attributes: [ :id, :name, :description ]
    )
  end
end
