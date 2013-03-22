class ApplicationController < ActionController::Base
  protect_from_forgery
  skip_before_filter :verify_authenticity_token

  def check_credentials!(credential)
    current_user.role.name == credential
  end
  
end
