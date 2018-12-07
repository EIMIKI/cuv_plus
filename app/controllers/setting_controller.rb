class SettingController < ApplicationController
  before_action :set_cookie,{only:[:post]}
  before_action :set_session

  def index

    # サイトごとに作品取得
    sites=Site.all
    @comics=Hash.new()
    sites.each do |site|
      @comics[site.name]=Comic.where(site_id:site.id)
    end

    # ユーザがチェック済みの作品
    @checked_comics_id=[]
    if session[:user]
      checked_comics=Comic.includes(:users).where('users.id'=>session[:user])
      checked_comics.each do |comic|
        @checked_comics_id.push(comic.id)
      end
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

    flash[:notice]="設定を変更しました"
    redirect_to("/")
  end
end
