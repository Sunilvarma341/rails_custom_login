class UserMailer < ApplicationMailer
  def password_reset(user)
    @user =  user
    @reset_link =  reset_password_edit_url(token: @user.reset_password_token)
    Rails.logger.debug "Reset Link: #{@reset_link}"

    mail(
      to: @user.email,
      content_type: "text/html",
      subject: "Reset Your Password"
    )
  end
end
