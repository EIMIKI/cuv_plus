require 'securerandom'

class ApplicationController < ActionController::Base

  before_action :set_session

  def user?
    return cookies[:user]
  end

  def set_session

    # クッキーが無い時
    if !user?
      uuid=SecureRandom.uuid
      new_user=User.create(uuid:uuid)
      new_user_id=new_user.uuid
      cookies.permanent[:user]=new_user_id
    end

    # セッションが無い時
    if !session[:user]
      session[:user]=cookies[:user]
    end

    # セッションが不正な時
    if !User.find_by(uuid:session[:user])
      reset_session
      cookies.delete :user
      redirect_to("/session_error")
    end

  end
end
