require 'open-uri'

namespace :scrape_urasunday do

  desc '裏サンデーのwebサイトから更新情報を取得'
  task :scrape => :environment do

    url='https://urasunday.com/'
    charset=nil

    html=open(url) do |page|
      charset=page.charset
      page.read
    end

    content=Nokogiri::HTML.parse(html,nil,charset)

    # タイトルごとの大枠
    content.css('.comicList ul li').each do |indexMainBox|

      # NEW!の表記の有無を判定
      if !indexMainBox.at('.indexMainTitleNew')
        next
      end

      # title取得部
      title=indexMainBox.at('a').inner_html
      puts("タイトル:#{title}")
      # url取得部
      atag=indexMainBox.at('a')
      url="https://urasunday.com/#{atag[:href]}"
      puts("URL:#{url}")
      # thum_url取得部
      divtag=atag=indexMainBox.at('div')
      thum_url="https://urasunday.com/#{divtag[:style]}"
      thum_url.sub!("background: url(","")
      thum_url.sub!(")","")
      puts("サムネイル:#{thum_url}")
      puts("-----------------------------------------")

      # DB更新
      comic=Comic.find_or_initialize_by(title:title)
      comic.update(title:title,url:url,thum_url:thum_url,site_id:1)
    end
  end
end
