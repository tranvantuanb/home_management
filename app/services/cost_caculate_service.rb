class CostCaculateService
  PRICE_1 = 1549
  PRICE_2 = 1600
  PRICE_3 = 1858
  PRICE_4 = 2340
  PRICE_5 = 2615
  PRICE_6 = 2701
  THREE_SOLD_1 = 50 / 3.0
  THREE_SOLD_2 = 100 / 3.0

  def initialize
  end

  def electric_cost current_consumption
    if current_consumption <= THREE_SOLD_1
        payment = current_consumption * PRICE_1
    elsif current_consumption <= 2 * THREE_SOLD_1
      payment = THREE_SOLD_1 * PRICE_1 + (current_consumption - THREE_SOLD_1) * PRICE_2
    elsif current_consumption <= 2 * THREE_SOLD_1 + THREE_SOLD_2
      payment = THREE_SOLD_1 * PRICE_1 + THREE_SOLD_1 * PRICE_2 +
        (current_consumption - (2 * THREE_SOLD_1 + THREE_SOLD_2)) * PRICE_3
    elsif current_consumption <= 2 * THREE_SOLD_1 + 2 * THREE_SOLD_2
      payment = THREE_SOLD_1 * PRICE_1 + THREE_SOLD_1 * PRICE_2 +
        THREE_SOLD_2 * PRICE_3 + (current_consumption - (2 * THREE_SOLD_1 + 2 * THREE_SOLD_2)) * PRICE_4
    elsif current_consumption <= 2 * THREE_SOLD_1 + 3 * THREE_SOLD_2
      payment = THREE_SOLD_1 * PRICE_1 + THREE_SOLD_1 * PRICE_2 +
        THREE_SOLD_2 * PRICE_3 + THREE_SOLD_2 * PRICE_4 + (current_consumption - (2 * THREE_SOLD_1 + 2 * THREE_SOLD_2)) * PRICE_5
    else
      payment = THREE_SOLD_1 * PRICE_1 + THREE_SOLD_1 * PRICE_2 +
        THREE_SOLD_2 * PRICE_3 + THREE_SOLD_2 * PRICE_4 + THREE_SOLD_2 * PRICE_5 + (current_consumption - (2 * THREE_SOLD_1 + 3 * THREE_SOLD_2)) * PRICE_6
    end
    payment
  end

  def auto_create_user_cost floor_cost
    total_floor_users = floor_cost.floor.users.size
    electric_cost = floor_cost.electric_cost * 1.0 / total_floor_users
    cost = floor_cost.cost

    if cost
      water_cost = floor_cost.cost.total_payment_water * 1.0 / User.where("floor_id is not null").size
      month = floor_cost.month
      floor_cost.floor.users.each do |u|
        user_cost = UserCost.find_by user_id: u.id, cost_id: floor_cost.cost.id
        if user_cost
          user_cost_params = {electric_cost: electric_cost, water_cost: water_cost}
          user_cost.update_attributes user_cost_params
        else
          user_cost_params = {user_id: u.id, cost_id: floor_cost.cost.id, electric_cost: electric_cost, water_cost: water_cost, month: month}
          UserCost.create user_cost_params
        end
      end
    end
  end
end
