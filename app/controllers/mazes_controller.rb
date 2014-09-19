class MazesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :ensure_user_has_created_profile
  
  def index
    @mazes = Maze.all.published | Maze.where(author: current_user)
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
      flash[:errors] = @maze.errors.full_messages
      render :new
    end
  end
  
  def show
    @maze = Maze.find(params[:id])
    
    redirect_to current_user unless @maze.author == current_user
  end
  
  def edit
    @maze = Maze.find(params[:id])
    
    if @maze.author == current_user
      render :edit
    else
      redirect_to @maze.author
    end
  end
  
  def publish
    @maze = Maze.find(params[:id])
    
    if @maze.update(published: true)
      
    else
      flash[:errors] = @maze.errors.full_messages
    end
         
    redirect_to @maze
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
  
  def play
    @maze = Maze.find(params[:id])
    @history = History.find_or_initialize_by(user: current_user, maze: @maze)
    @current_room = @history.current_room
    @rating = current_user.ratings.find_by(maze: @maze)
    
    if @current_room && @current_room.win
      @history.win_count += 1
      @history.room_id = nil
    elsif @current_room && @current_room.lose
      @history.loss_count += 1
      @history.room_id = nil
    end
    
    @history.save
  end
  
  def move_to_room
    @maze = Maze.find(params[:id])
    @room = Room.find(params[:room_id])
    @history = History.find_or_initialize_by(user: current_user, maze: @maze)
    
    if @history.room_id
      @current_room = Room.find(@history.room_id)
      
      if @current_room.next_rooms.include?(@room)
        @history.update(room_id: @room.id)
      else
        flash[:error] = "You cannot move to that room out of order."
      end
    elsif @room == @maze.start_room
      @history.update(room_id: @room.id)
    end
    
    redirect_to action: "play"
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
