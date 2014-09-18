class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  private
  
  def ensure_user_has_created_profile
    unless current_user.profile
      flash[:error] = "Please finish creating your profile before using the rest of the site."
      
      redirect_to new_user_profile_url(current_user)
    end
  end
end
