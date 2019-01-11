require 'open-uri'

namespace :scrape_yawaraka do

  desc 'やわらかスピリッツのwebサイトから更新情報を取得'
  site_id=3
  task :scrape => :environment do

    url='http://yawaspi.com/'
    site_name="やわらかスピリッツ"
    charset=nil

    # 初回スクレイピングでサイトをDBに追加
    site=Site.find_or_create_by(name:site_name)
    site_id=site.id

    html=open(url) do |page|
      charset="utf-8"
      page.read
    end

    content=Nokogiri::HTML.parse(html,nil,charset)

    # 日付の取得
    today="#{Date.today}"
    today.gsub!("-","/")

    # タイトルの大枠
    content.css('#indexComicList ul li').each do |comicHtml|
      comic="#{comicHtml}"
      if comic.index(today)

        title_html=comicHtml.css('.iclLeft p').inner_html
        if title_html!=""
          # title取得部
          title="#{title_html.split("<")[0]}"
          title.gsub!("\r\n","")
          puts(title)

          # url取得部
          atag=comicHtml.at('a')
          url="http://yawaspi.com/#{atag.attr('href')}"
          puts(url)

          # thum_url取得部
          divtag=comicHtml.css('.iclBanner')
          thum_url="http://yawaspi.com/#{divtag.attr('style')}"
          thum_url.sub!("background: url(","")
          thum_url.sub!(")","")
          puts(thum_url)
          puts("-----------------------------------------")

          # DB更新
          comic=Comic.find_or_initialize_by(title:title,site_id:site_id)
          comic.update(title:title,url:url,thum_url:thum_url,site_id:site_id)
          comic.touch
        end
      end
    end
  end
end
