class ChangeFloorCostsToRoomCosts < ActiveRecord::Migration[5.0]
  def change
    rename_table :floor_costs, :room_costs
    rename_table :floors, :rooms
  end
end
