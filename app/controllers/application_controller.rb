class ApplicationController < ActionController::Base

  before_action :set_session

  def user?
    return cookies[:user]
  end

  def set_session

    # クッキーが無い時
    if !user?
      new_user=User.create
      new_user_id=new_user.id
      cookies.permanent[:user]=new_user_id
    end

    # セッションが無い時
    if !session[:user]
      session[:user]=cookies[:user]
    end

    # セッションが不正な時
    if !User.find_by(id:session[:user])
      reset_session
      cookies.delete :user
      redirect_to("/session_error")
    end

  end
end
