require 'open-uri'

namespace :scrape_urasunday do

  desc '裏サンデーのwebサイトから更新情報を取得'
  site_id=1
  task :scrape => :environment do

    url='https://urasunday.com/'
    site_name="裏サンデー"
    charset=nil

    # 初回スクレイピングでサイトをDBに追加
    site=Site.find_or_create_by(name:site_name)
    site_id=site.id

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
      comic=Comic.find_or_initialize_by(title:title,site_id:site_id)
      comic.update(title:title,url:url,thum_url:thum_url,site_id:site_id)
    end
  end
end
