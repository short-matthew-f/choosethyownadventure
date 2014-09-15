class UsersController < ApplicationController
  before_filter :authenticate_user!
  
  def show
    if params[:id]
      @user = User.find(params[:id])
    else
      @user = current_user
    end
    
    @profile = Profile.find_by(user: @user)
    
    redirect_to new_user_profile_url(@user) unless @profile
  end
  
  def edit
    
  end
  
  def index
    @users = User.all
  end
end
