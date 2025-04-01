class SignInController < ApplicationController
  def new
    @user =  User.new
  end

  def create
    email  =  params[:email]
    password =  params[:password]
    user =  User.find_by(email: email)
    if user && user.authenticate(password)
    login(user)
    redirect_to root_path, notice: "Logged In successfully"
    else
      flash.now[:alert] = "Invalid email or password"
      render :new
    end
  end

  def destroy
    logout()
    redirect_to sign_in_path,  notice: "Logged out successfully"
  end
end
