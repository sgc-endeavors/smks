class ApplicationController < ActionController::Base
  protect_from_forgery
 
  rescue_from CanCan::AccessDenied do |exception|
  	flash[:alert] = "Beat it!... Access Denied!"
  	redirect_to root_url
  end

end
