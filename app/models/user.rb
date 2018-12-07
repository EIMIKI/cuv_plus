class User < ApplicationRecord
  has_and_belongs_to_many :comics
  validates :uuid, {presence: true}
end
