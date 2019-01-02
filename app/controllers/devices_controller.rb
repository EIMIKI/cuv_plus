class DevicesController < ApplicationController
  def create
    user = User.find(session[:user])

    device = Device.find_by(user_id:user.id)
    if !device
      device=Device.new
    end
    device = Device.update(endpoint:params[:subscription][:endpoint],
                        p256dh:params[:subscription][:keys][:p256dh],
                        auth:params[:subscription][:keys][:auth],
                        user_id:user.id)

    device.save
  end
end
