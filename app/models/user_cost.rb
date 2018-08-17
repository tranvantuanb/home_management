class UserCost < ApplicationRecord
  belongs_to :user
  belongs_to :cost

  scope :filter_by_month, -> month do
    if month.present?
      where("MONTH(month) = ? and YEAR(month) = ?", month.month, month.year)
    else
      all
    end
  end
end
