class WelcomeController < ApplicationController
  def index
    @users = User.all
    @user =  User.find_by(:id => session[:user_id])
  end
end