class RoomsController < ApplicationController
  
  def new
    @maze = Maze.find(params[:maze_id])
    
    @room = Room.new(maze: @maze)
  end
  
  def create 
    @maze = Maze.find(params[:maze_id])
    
    @room = Room.new(maze: @maze)
    @room.assign_attributes(room_params)
    
    if @room.save
      redirect_to @room
    else
      flash[:errors] = @room.errors.full_messages
      render :new
    end
  end
  
  def show
    @room = Room.find(params[:id])
  end
  
  def edit
    @room = Room.find(params[:id])
  end
  
  def update
    @room = Room.find(params[:id])
    
    if @room.update(room_params)
      redirect_to @room
    else
      flash[:errors] = @room.errors.full_messages
      render :edit
    end
  end
  
  def destroy
    @room = Room.find(params[:id])
    
    @room.destroy
    
    redirect_to @room.maze
  end
  
  def move_start
    @room = Room.find(params[:id])
    
    @start_room = @room.maze.start_room
    
    @room.start = true
    @start_room.start = false if @start_room
    
    if @room.save
      @start_room.save if @start_room
      redirect_to @room.maze
    else
      flash[:error] = "Whoops."
      redirect_to @room.maze
    end
  end
  
  private
  
  def room_params
    params.require(:room).permit(:name, :description, :start, :win, :lose)
  end
  
end
