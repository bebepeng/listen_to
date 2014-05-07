class WelcomeController < ApplicationController
  def index
    @users = User.all
    @user =  User.find_by(:id => session[:user_id])
  end
  def logout
    session[:user_id] = nil
    redirect_to '/'
  end
end