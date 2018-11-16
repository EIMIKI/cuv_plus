class HomeController < ApplicationController
  def index
    @comics=Comic.where(updated_at:Time.zone.now.all_day)
    @old_comics=Comic.where.not(updated_at:Time.zone.now.all_day)
  end
end
