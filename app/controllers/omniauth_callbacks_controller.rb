class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def facebook
    raise "HELL" #request.env["omniauth.auth"].to_yaml

 		# if user.persisted?
   #    sign_in_and_redirect user, notice: "Signed in!"
	  # else
	  #   redirect_to new_user_registration_url
	  # end
  end 


end
