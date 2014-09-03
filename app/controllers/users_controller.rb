class UsersController < ApplicationController
  before_filter :authenticate_user!
  
  def show
    @user = current_user
    @profile = @user.profile
  end
  
  def edit
    
  end
end
