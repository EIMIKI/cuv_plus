require 'securerandom'

class ApplicationController < ActionController::Base

  before_action :set_session

  def user?
    return cookies[:user]
  end

  def set_cookie
    # クッキーが無い時
    if !user?
      uuid=SecureRandom.uuid
      new_user=User.create(uuid:uuid)
      new_user_id=new_user.uuid
      cookies.permanent[:user]=new_user_id
    end
  end

  def set_session
    # セッションが無い時
    if user? && !session[:user]
      session[:user]=User.find_by(uuid:cookies[:user]).id
    else
      return
    end

    # セッションが不正な時
    if !User.find_by(id:session[:user])
      reset_session
      cookies.delete :user
      redirect_to("/session_error")
    end

  end
end
