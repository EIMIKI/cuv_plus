require 'open-uri'

namespace :scrape_sundaywebry do

  desc 'サンデーうぇぶりのwebサイトから更新情報を取得'
  task :scrape => :environment do

    url='https://www.sunday-webry.com/'
    charset=nil

    html=open(url) do |page|
      charset=page.charset
      page.read
    end

    content=Nokogiri::HTML.parse(html,nil,charset)

    # 当日更新タイトルの大枠
    content.css('#today').each do |today|
      # タイトルごとの大枠
      today.css('.box_serial').each do |comic|

        # title取得部
        imgtag=comic.at('img')
        title=imgtag[:alt]
        puts(title)

        # url取得部
        url=comic.css('a').attr('href')
        puts(url)

        # thum_url取得部
        thum_url=imgtag[:src]
        puts(thum_url)
        puts("-----------------------------------------")

        # DB更新
        comic=Comic.find_or_initialize_by(title:title)
        comic.update(title:title,url:url,thum_url:thum_url,site_id:2)
      end
    end
  end
end
