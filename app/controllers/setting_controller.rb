class SettingController < ApplicationController
  def index
    @us_comics=Comic.where(site_id:Site.find_by(name:'urasunday')[:id])
    @sw_comics=Comic.where(site_id:Site.find_by(name:'sundaywebry')[:id])
    @ys_comics=Comic.where(site_id:Site.find_by(name:'yawaraka')[:id])
  end

  def post
    params[:check].each do |id,check|
      if check=="1"
        comic=Comic.find_by(id:id)
        puts(comic.title)
      end
    end
  end
end
