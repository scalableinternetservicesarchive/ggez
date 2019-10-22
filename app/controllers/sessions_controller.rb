class SessionsController < ApplicationController
  # GET /login
  def new
  end

  # POST /login
  def create
    user = User.find_by(username: params[:session][:username])
    if user&.authenticate(params[:session][:password])
      log_in(user.id)
      redirect_to root_path
    else
      flash.now[:danger] = 'Invalid login'
      render 'new'
    end
  end


  def delete
    log_out
    redirect_to root_path
  end
end
