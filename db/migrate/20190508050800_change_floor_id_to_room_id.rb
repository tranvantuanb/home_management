class ChangeFloorIdToRoomId < ActiveRecord::Migration[5.0]
  def change
    rename_column :room_costs, :floor_id, :room_id
    rename_column :users, :floor_id, :room_id
  end
end
