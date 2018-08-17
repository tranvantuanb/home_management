class CreateUserCost < ActiveRecord::Migration[5.0]
  def change
    create_table :user_costs do |t|
      t.date :month
      t.float :electric_cost, default: 0
      t.float :water_cost, default: 0
      t.belongs_to :user, index: true
      t.belongs_to :cost, index: true

      t.timestamps
    end
  end
end
