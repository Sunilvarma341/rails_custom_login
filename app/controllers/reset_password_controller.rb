class ResetPasswordController < ApplicationController
  def new
  end

  def create
    begin
      user =  User.find_by(email: params[:email])
      if user
        user.generate_user_reset_token!
        UserMailer.password_reset(user).deliver_now
        flash[:notice] = "Password reset email sent!"
      else
         flash.now[:alert] = "Email Not Found"
         render :new
      end
    rescue Exception
      render :new
      flash.now[:alert] = "Something went wrong"
    end
  end

  def edit
    @user =  User.find_by(reset_password_token: params[:token])
  end

  def update
    @user =  User.find_by(reset_password_token: params[:token])
    Rails.logger("========== 2.hours.ago  @#{@user.reset_password_sent_at}    #{2.hours.ago }")
    if @user && @user.reset_password_sent_at > 2.hours.ago
      if @user.update(reset_password_params)
        @user.update(reset_password_token: nil,  reset_password_sent_at: nil)
        redirect_to sign_in_path, notice: "Password has been reset!"
      else
        redirect_to new_reset_password_path, alert: "Password reset has expired"
      end
    else

    end
    # password =
  end

  private
  def reset_password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
