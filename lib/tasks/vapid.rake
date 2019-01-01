namespace :vapid do
  desc:"vapidの生成(一度のみ実行)"
  task :generate do
    pub="VAPID_PUBLIC_KEY"
    pri="VAPID_PRIVATE_KEY"

    vapid_key=Webpush.generate_key

    open(".env","w"){|f|
      f.puts "#{pub}=#{vapid_key.public_key}"
      f.puts "#{pri}=#{vapid_key.private_key}"
    }

    Dotenv.load
  end
end
