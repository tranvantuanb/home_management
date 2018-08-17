class FloorCost < ApplicationRecord
  belongs_to :cost, optional: true
  belongs_to :floor

  ATTRIBUTE_PARAMS = [:amount_electric_consumption, :floor_id, :month, :cost_id]

  validate :check_duplicate_month

  scope :get_by_month, -> month do
    where("MONTH(month) = ? and YEAR(month) = ?", month.month, month.year)
  end

  def check_duplicate_month
    if self.id
      exist_month = FloorCost.where("MONTH(month) = ? and YEAR(month) = ? and floor_id = ? and id <> ?",
        self.month.month, self.month.year, self.floor_id, self.id).first
    else
      exist_month = FloorCost.where("MONTH(month) = ? and YEAR(month) = ? and floor_id = ?",
        self.month.month, self.month.year, self.floor_id).first
    end
    if exist_month.nil?
      true
    else
      errors.add(:duplicate_month, "Tháng đã tồn tại")
    end
  end

  def get_current_consumption month
    last_month_amount_consumption = get_last_month_floor_cost month
    current_consumption = 0
    if last_month_amount_consumption
      current_consumption = self.amount_electric_consumption - last_month_amount_consumption.amount_electric_consumption
    end
    current_consumption
  end

  def get_last_month_floor_cost month
    last_month = month - 1.month
    FloorCost.where("MONTH(month) = ? and YEAR(month) = ? and floor_id = ?", last_month.month, last_month.year, self.floor_id).first
  end
end
