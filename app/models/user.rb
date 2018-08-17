class User < ApplicationRecord
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  ATTRIBUTE_PARAMS = [:email, :name, :password, :password_confirmation, :floor_id,
      :address, :phone_number, :role]
  belongs_to :floor, optional: true
  has_many :user_costs
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  enum role: [:member, :admin]
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def slug_candidates
    [
      :name,
      [:name, :email]
    ]
  end
  class << self
    def role_name
      ["member", "admin"]
    end
  end
end
