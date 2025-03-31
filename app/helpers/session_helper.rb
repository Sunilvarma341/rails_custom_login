module  SessionHelper
  def login(user)
    puts "SessionHelper #{session}"
    session[:user_id] = user.id
  end

  def logout
    session.delete(:user_id)
    @current_user = nil
  end

  def current_user
    session_user_id =  session[:user_id]
    @current_user ||=  User.find(session_user_id)
  end

  def logged_in?
    puts ("logged in  #{!@current_user}")
    !@current_user.nil?
  end
end
