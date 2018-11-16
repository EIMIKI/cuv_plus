class Comic < ApplicationRecord
  belongs_to :site

  validates :title, {presence: true}
  validates :url, {presence: true}
  validates :thum_url, {presence: true}
  validates :site_url, {presence: true}
end
