class CreateCosts < ActiveRecord::Migration[5.0]
  def change
    create_table :costs do |t|
      t.date :month
      t.float :total_payment_electric, default: 0
      t.float :total_payment_water, default: 0
      t.integer :amount_electric, default: 0
      t.integer :amount_water, default: 0
      t.timestamps
    end
  end
end
