class PushController
  def send_push
    devices=Device.all
    devices.each do |device|
      message=create_message(device.user_id)
      if message
        webpush(device,message)
      end
    end
  end

  def webpush(device,message)
    Webpush.payload_send(
      message: message,
      endpoint: device.endpoint,
      p256dh: device.p256dh,
      auth: device.auth,
      ttl: 24*60*60,
      vapid:{
        public_key: ENV["VAPID_PUBLIC_KEY"],
        private_key: ENV["VAPID_PRIVATE_KEY"]
      }
    )
  end

  def create_message(user_id)
    collection=Comic.includes(:users).where('users.id'=>user_id)
    unless collection.empty?
      count=collection.where(updated_at:Time.zone.now.all_day).count
    else
      return nil
    end

    message="本日(#{Date.today})更新された作品があります。\n作品数:#{count}"
    return message
  end
end
