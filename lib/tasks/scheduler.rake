desc "This task is called by the Heroku scheduler add-on"
task :get_update => :environment do
  puts "get urasunday"
  Rake::Task["scrape_urasunday:scrape"].invoke
  puts "get sundaywebry"
  Rake::Task["scrape_sundaywebry:scrape"].invoke
  puts "get yawaraka"
  Rake::Task["scrape_yawaraka:scrape"].invoke
end

task :send_push => :environment do
  puts "send_push"
  Rake::Task["webpush"].invoke
end
