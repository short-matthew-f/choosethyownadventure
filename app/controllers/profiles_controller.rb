class ProfilesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :ensure_user_has_created_profile, except: [:new, :create]
  
  def new
    @user = current_user
    @profile = Profile.new(user: @user)
  end
  
  def create
    @user = current_user
    
    @profile = Profile.new(user: @user)
    @profile.assign_attributes(profile_params)

    if @profile.save
      redirect_to current_user 
    else
      render :new
    end
  end
  
  def edit
    @user = current_user
    
    @profile = Profile.find_by(user: @user)
  end
  
  def update
    @user = current_user
    
    @profile = Profile.find_by(user: @user)
    
    if @profile.update(profile_params)
      redirect_to current_user
    else
      render :edit
    end
  end
  
  
  private
  
  def profile_params
    params.require(:profile).permit(:name, :location, :biography, :visible, :avatar)
  end
end
