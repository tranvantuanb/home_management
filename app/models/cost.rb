class Cost < ApplicationRecord

  ATTRIBUTE_PARAMS = [:month, :total_payment_electric, :total_payment_water, :amount_electric,
    :amount_water]

  has_many :room_costs

  validate :check_duplicate_month

  scope :get_by_month, -> month do
    where("MONTH(month) = ? and YEAR(month) = ?", month.month, month.year).first
  end

  def devide_to_person
    cost_last_month = Cost.where("MONTH(month) = ? and YEAR(month) = ?", self.month.month - 1, self.month.year).first

  end

  def check_duplicate_month
    if self.id
      exist_month = Cost.where("MONTH(month) = ? and YEAR(month) = ? and id <> ?", self.month.month, self.month.year, self.id).first
    else
      exist_month = Cost.where("MONTH(month) = ? and YEAR(month) = ?", self.month.month, self.month.year).first
    end

    if exist_month.nil?
      true
    else
      errors.add(:duplicate_month, "Tháng đã tồn tại")
    end
  end

  class << self
    def statistic_electric
      payment_electric = Cost.where("month >= ? and month <= ?", Date.today.beginning_of_year, Date.today).map(&:total_payment_electric)
    end

    def statistic_water
      payment_water = Cost.where("month >= ? and month <= ?", Date.today.beginning_of_year, Date.today).map(&:total_payment_water)
    end

    def get_months
      months = Cost.where("month >= ? and month <= ?", Date.today.beginning_of_year, Date.today).pluck :month
      month_array = []
      months.each do |m|
        month_array << I18n.t(".month") + m.month.to_s
      end
      month_array
    end

    def get_current_cost
      Cost.where("MONTH(month) = ? and YEAR(month) = ?", Date.today.month, Date.today.year).first
    end
  end
end
