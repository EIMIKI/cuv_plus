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
    today_collection=collection.where(updated_at:Time.zone.now.all_day)
    unless today_collection.empty?
      count=today_collection.count
    else
      return nil
    end

    title="本日(#{Date.today})更新された作品があります。作品数:#{count}"

    body=[]
    today_collection.each do |comic|
      body.push(comic.title)
    end
    p body
    message=JSON.generate({"title":title,"body":body})
    return message
  end
end
