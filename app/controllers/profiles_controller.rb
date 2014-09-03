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
  
  
  private
  
  def profile_params
    params.require(:profile).permit(:name, :location, :birthdate, :biography, :visible, :avatar)
  end
end
