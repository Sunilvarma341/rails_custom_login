class SignUpController < ApplicationController
  def new
    @user =  User.new
  end

  def create
    @user =  User.new(sign_up_params)
    if @user.save
      redirect_to root_path,  notice: "Account created successfully"
    else
      render :new
    end
  end

  private
  def sign_up_params
    params.require(:user).permit(:email,  :password,  :password_confirmation)
  end
end
