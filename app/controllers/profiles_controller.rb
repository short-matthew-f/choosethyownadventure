class ProfilesController < ApplicationController
  def create
    @user = current_user
    
    @profile = Profile.new(user: @user)
    @profile.assign_attributes(profile_params)

    if @profile.save
      flash[:success] = "Your profile has been created!"
    else
      flash[:error] = "There are errors with your profile."
    end
    
    redirect_to current_user 
  end
  
  def edit
    @profile = Profile.find(params[:id])
    
    if @profile.user == current_user
      render :edit
    else
      flash[:error] = "No thank you."
      redirect_to current_user
    end
  end
  
  def update
    @profile = Profile.find(params[:id])
    
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
