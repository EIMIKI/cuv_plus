class DevicesController < ApplicationController
  def create
    device = Device.find_by(endpoint:params[:subscription][:endpoint])
    if !device
      user = User.find(session[:user])
      device = Device.new(endpoint:params[:subscription][:endpoint],
                          p256dh:params[:subscription][:keys][:p256dh],
                          auth:params[:subscription][:keys][:auth],
                          user_id:user.id)

      device.save
    end
  end
end
