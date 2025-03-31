class UserMailer < ApplicationMailer
  def password_reset(user)
    @user =  user
    @reset_link =  edit_password_reset_url(@user.reset_password_token)

    mail(
      to: @user.email,
      subject: "Reset Your Password"
    )
  end
end
