class CreateFloorCost < ActiveRecord::Migration[5.0]
  def change
    create_table :floor_costs do |t|
      t.integer :amount_electric_consumption, default: 0
      t.float :electric_cost, default: 0
      t.float :water_cost, default: 0
      t.date :month
      t.belongs_to :floor, index: true
      t.belongs_to :cost, index: true

      t.timestamps
    end
  end
end
