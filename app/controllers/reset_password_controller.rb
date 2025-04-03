class ResetPasswordController < ApplicationController
  def new
  end

  def create
    # Rails.logger("reset password created #{params}")
    begin
      @user =  User.find_by(email: params[:email])
      puts "================== #{@user}=====================  #{params}"
      if @user
        @user.generate_user_reset_token!
        UserMailer.password_reset(@user).deliver_now
        flash[:notice] = "Password reset email sent!"
        # redirect_to root_path, notice: "Password reset instructions sent to your email"
        respond_to do |format|
          format.html { redirect_to root_path, notice: "Reset email sent!" }
          format.turbo_stream { render turbo_stream: turbo_stream.replace("flash", partial: "shared/flash") }
        end
      else
         flash.now[:alert] = "Email Not Found"
         render :new
      end
    rescue Exception => e
       puts "+=+===============  #{e.message}"
      flash.now[:alert] = "Something went wrong  #{e.message}"
      render :new
    end
  end

  def edit
    @user =  User.find_by(reset_password_token: params[:token])
  end

  def update
    begin
      @user = User.find_by(reset_password_token: params[:token])

      if @user.nil?
        Rails.logger.error("No user found for token: #{params[:token]}")
        redirect_to reset_password_edit_path, alert: "Invalid or expired reset token" and return
      end

      Rails.logger.debug("User found: #{@user.email}, reset_password_sent_at: #{@user.reset_password_sent_at} ,  params:#{params}")

      if @user.reset_password_sent_at > 2.hours.ago
        if @user.update(reset_password_params)
          @user.reset_password_token_update_nil!
          redirect_to sign_in_path, notice: "Password has been reset!"
        else
          redirect_to reset_password_edit_path, alert: "Failed to update password"
        end
      else
        redirect_to reset_password_edit_path, alert: "Password reset has expired"
      end
    rescue => e
      Rails.logger.error("Error in reset password: #{e.message}   #{params[:user]}")
      redirect_to reset_password_edit_path, alert: "Something went wrong. Please try again."
    end
  end


  private
  def reset_password_params
    params.permit(:password, :password_confirmation)
  end
end
