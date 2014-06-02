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
    owner = User.find(params[:id])
    @is_an_owner = is_owner?(owner)
    @user = User.find(params[:id])
  end

  def edit
    owner = User.find(params[:id])
    if is_owner?(owner)
      @user = User.find(session[:user_id])
    else
      redirect_to user_path(params[:id])
    end
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(user_params_for_update)
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    user = User.find(login_id)
    if is_owner?(user)
      user.destroy
      session[:user_id] = nil
      redirect_to root_path
    end
  end

  private

  def users
    @_users ||= User.all
  end

  def user_params_for_create
    params.require(:user).permit(:email, :username, :password, :password_confirmation)
  end

  def user_params_for_update
    params.require(:user).permit(:username)
  end
end