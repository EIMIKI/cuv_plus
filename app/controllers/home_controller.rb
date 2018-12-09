class HomeController < ApplicationController
  def index
    collection=Comic.includes(:users).where('users.id'=>session[:user])

    if !collection.empty? && session[:user]
      @comics=collection.where(updated_at:Time.zone.now.all_day).shuffle
      @old_comics=collection.where.not(updated_at:Time.zone.now.all_day).order("comics.updated_at DESC")
    else
      @comics=Comic.where(updated_at:Time.zone.now.all_day).shuffle
      @old_comics=Comic.where.not(updated_at:Time.zone.now.all_day).order("updated_at DESC")
    end

  end

  def about

  end
end
