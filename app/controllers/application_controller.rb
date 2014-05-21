class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :is_owner?

  def is_owner?(id)
    if logged_in?
      User.find(login_id) == User.find(id)
    else
      false
    end
  end

  def logged_in?
    login_id != nil
  end

  def login_id
    session[:user_id]
  end
end
