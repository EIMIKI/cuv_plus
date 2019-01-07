desc "登録されているユーザに通知を送信する"
task :webpush => :environment do
  pc=PushController.new
  pc.send_push
end
