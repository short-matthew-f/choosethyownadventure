class UsersController < ApplicationController
  before_filter :authenticate_user!
  
  def show
    if params[:id]
      @user = User.find(params[:id])
    else
      @user = current_user
    end
    
    if @user == current_user
      @profile = @user.profile ? @user.profile : Profile.new(user: @user)
    else
      @profile = @user.profile
    end
  end
  
  def edit
    
  end
end
