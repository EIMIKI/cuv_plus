class Comic < ApplicationRecord
  belongs_to :site
  has_and_belongs_to_many :users

  validates :title, {presence: true}
  validates :url, {presence: true}
  validates :thum_url, {presence: true}
  validates :site_id, {presence: true}
end
