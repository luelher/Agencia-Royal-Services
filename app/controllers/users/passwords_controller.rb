class Users::PasswordsController < Devise::PasswordsController
  layout 'intranet'
  skip_before_filter :require_no_authentication, :only => [:edit, :update]
  skip_before_filter :assert_reset_token_passed

  def update
    current_user.reset_password_token = params[:user][:reset_password_token]
    current_user.reset_password_sent_at = 2.minutes.ago
    current_user.save
    super
  end

end
