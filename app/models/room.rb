class Room < ApplicationRecord
  has_many :room_costs
  has_many :users

  validates :name, uniqueness: { case_sensitive: false }, presence: true
end
