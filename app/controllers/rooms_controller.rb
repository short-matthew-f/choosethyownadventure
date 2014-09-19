class RoomsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :ensure_user_has_created_profile
  
  def new
    @maze = Maze.find(params[:maze_id])
    @room = Room.new(maze: @maze)
    
    @maze.rooms.each do |r|
      @room.entrances.find_or_initialize_by(entrance: r) unless r.id == @room.id
    end
  end
  
  def create 
    @maze = Maze.find(params[:maze_id])
    
    @room = Room.new(room_params)
    @room.maze = @maze
    @room.win, @room.lose = win_conditions
    
    if @room.save
      update_entrances(@room) unless @room.is_only_room?
      
      @maze.update(published: false)
      
      redirect_to @maze
    else
      @maze.rooms.each do |r|
        @room.entrances.find_or_initialize_by(entrance: r) unless r.id == @room.id
      end
      
      flash[:errors] = @room.errors.full_messages
      render :new
    end
  end
  
  def show
    @room = Room.find(params[:id])
  end
  
  def edit
    @room = Room.find(params[:id])
    
    @room.maze.rooms.each do |r|
      @room.entrances.find_or_initialize_by(entrance: r) unless r.id == @room.id
    end
  end
  
  def update
    @room = Room.find(params[:id]) 
    @maze = @room.maze
    
    @room.win, @room.lose = win_conditions
    
    if @room.update(room_params)
      update_entrances(@room) unless @room.is_only_room?
      
      @maze.update(published: false)
      
      redirect_to @maze
    else
      @maze.rooms.each do |r|
        @room.entrances.find_or_initialize_by(entrance: r) unless r.id == @room.id
      end
      
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
    params.require(:room).permit(
      :name, 
      :description,
      picture_attributes: [ :image ]
    )
  end
  
  def win_condition_params
    params.require(:room).permit(:win_condition)
  end
  
  def entrance_params
    params.require(:room).require(:entrances_attributes)
  end
  
  def update_entrances(room)
    entrances_hash = entrance_params.select { |k,v| !v["description"].blank? }
    entrances_ids = entrances_hash.map { |k,v| v['entrance_id'] }
    
    entrances_hash.each do |k, v|
      entrance = Hallway.find_or_initialize_by(entrance_id: v['entrance_id'], exit: room)
      entrance.update(description: v["description"])
    end
    
    room.previous_room_ids = entrances_ids
  end
  
  def win_conditions
    case win_condition_params.require("win_condition")
    when "win"
      [true, false]
    when "lose"
      [false, true]
    else
      [false, false]
    end
  end
  
end
