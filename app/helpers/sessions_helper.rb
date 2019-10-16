module SessionsHelper
  def log_in(user_id)
    session[:user_id] = user_id
  end

  def log_out
    session[:user_id] = nil
  end

  def current_user
    if session[:user_id]
      User.find_by(id: session[:user_id])
    end
  end

  def logged_in?
    !current_user.nil?
  end
end
