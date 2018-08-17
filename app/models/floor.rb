class Floor < ApplicationRecord
  has_many :floor_costs
  has_many :users

  validates :name, uniqueness: { case_sensitive: false }, presence: true
end
