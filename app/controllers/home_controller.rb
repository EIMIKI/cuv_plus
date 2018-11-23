class HomeController < ApplicationController
  def index
    @comics=Comic.where(updated_at:Time.zone.now.all_day).shuffle
    @old_comics=Comic.where.not(updated_at:Time.zone.now.all_day).order("updated_at DESC")
  end
end
