class ApplicationController < ActionController::Base
  protect_from_forgery

  def check_credentials!(credential)
    current_user.role.name == credential
  end
  
end
