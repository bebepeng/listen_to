class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.find_by_case_insensitive_email(params[:user][:email])
    if user && user.authenticate(params[:user][:password])
      session[:user_id] = user.id
      redirect_to root_path
    else
      @user = User.new(user_params)
      redirect_to '/login', :flash => {:authentication_error => 'Invalid Username or Password'}
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/'
  end

  private

  def users
    @_users ||= User.all
  end

  def user_params
    params.require(:user).permit(:email, :username, :password)
  end
end
