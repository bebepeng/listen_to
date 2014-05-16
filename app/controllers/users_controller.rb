class UsersController < ApplicationController
  def new
    if session[:user_id]
      redirect_to root_path
    else
      @user = User.new
    end
  end

  def create
    @user = users.new(user_params_for_create)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(session[:user_id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(user_params_for_update)
      redirect_to root_path
    else
      render :edit
    end
  end

  private

  def users
    @_users ||= User.all
  end

  def user_params_for_create
    params.require(:user).permit(:email, :username, :password)
  end

  def user_params_for_update
    params.require(:user).permit(:username)
  end
end