class ApplicationController < ActionController::Base

  before_action :set_session

  def user?
    return cookies[:user]
  end

  def set_session

    if !user?
      new_user=User.create
      new_user_id=new_user.id
      cookies.permanent[:user]=new_user_id
    end

    if !session[:user]
      session[:user]=cookies[:user]
    end

  end
end
