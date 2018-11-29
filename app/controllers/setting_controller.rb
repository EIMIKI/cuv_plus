class SettingController < ApplicationController
  def index
    @us_comics=Comic.where(site_id:Site.find_by(name:'urasunday')[:id])
    @sw_comics=Comic.where(site_id:Site.find_by(name:'sundaywebry')[:id])
    @ys_comics=Comic.where(site_id:Site.find_by(name:'yawaraka')[:id])


    checked_comics=Comic.includes(:users).where('users.id'=>session[:user])
    @checked_comics_id=[]
    checked_comics.each do |comic|
      @checked_comics_id.push(comic.id)
    end

  end

  def post
    user=User.find(session[:user])
    ids=[]

    user.comics.clear # 既に登録された関連を一旦削除
    params[:check].each do |id,check|
      if check=="1"
        ids.push(id)
      end
    end

    user.comics << Comic.find(ids)
    user.save
  end
end
