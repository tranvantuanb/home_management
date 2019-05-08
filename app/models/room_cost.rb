class RoomCost < ApplicationRecord
  belongs_to :cost, optional: true
  belongs_to :room

  ATTRIBUTE_PARAMS = [:amount_electric_consumption, :room_id, :month, :cost_id]

  validate :check_duplicate_month

  scope :get_by_month, -> month do
    where("MONTH(month) = ? and YEAR(month) = ?", month.month, month.year)
  end

  def check_duplicate_month
    if self.id
      exist_month = RoomCost.where("MONTH(month) = ? and YEAR(month) = ? and room_id = ? and id <> ?",
        self.month.month, self.month.year, self.room_id, self.id).first
    else
      exist_month = RoomCost.where("MONTH(month) = ? and YEAR(month) = ? and room_id = ?",
        self.month.month, self.month.year, self.room_id).first
    end
    if exist_month.nil?
      true
    else
      errors.add(:duplicate_month, "Tháng đã tồn tại")
    end
  end

  def get_current_consumption month
    last_month_amount_consumption = get_last_month_room_cost month
    current_consumption = 0
    if last_month_amount_consumption
      current_consumption = self.amount_electric_consumption - last_month_amount_consumption.amount_electric_consumption
    else
      current_consumption = self.amount_electric_consumption
    end
    current_consumption
  end

  def get_last_month_room_cost month
    last_month = month - 1.month
    RoomCost.where("MONTH(month) = ? and YEAR(month) = ? and room_id = ?", last_month.month, last_month.year, self.room_id).first
  end
end
