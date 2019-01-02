require 'securerandom'

class ApplicationController < ActionController::Base

  before_action :set_session
  helper_method :vapid_public_key

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
    if user?
      # クッキーが不正な時
      if !User.find_by(uuid:cookies[:user])
        reset_session
        cookies.delete :user
        redirect_to("/session_error")
        return
      end

      # セッションが無い時
      if !session[:user]
        session[:user]=User.find_by(uuid:cookies[:user]).id
      end
    end



  end

  def vapid_public_key
    @decode_vapid_public_key ||= Base64.urlsafe_decode64(ENV['VAPID_PUBLIC_KEY']).bytes
  end
end
