class MazesController < ApplicationController
  before_filter :authenticate_user!
  
  def new
    @maze = Maze.new(author: current_user)
  end
  
  def create
    @maze = Maze.new(author: current_user)
    @maze.assign_attributes(maze_params)
    
    if @maze.save
      flash[:success] = "Your maze has been created!"
      redirect_to @maze
    else
      flash[:error] = "There are errors with your maze."
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
      flash[:error] = "There are errors with your maze."
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
    params.require(:maze).permit(:title, :description)
  end
  
end
