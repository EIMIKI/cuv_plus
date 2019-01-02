class User < ApplicationRecord
  has_and_belongs_to_many :comics
  has_one :device
  validates :uuid, {presence: true}
end
