class UsersController < ApplicationController
  before_filter :authenticate_user!
  
  def show
    if params[:id]
      @user = User.find(params[:id])
      @profile = @user.profile
    else
      @user = current_user
      @profile = @user.profile ? @user.profile : Profile.new(user: @user)
    end
  end
  
  def edit
    
  end
end
