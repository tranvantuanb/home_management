class CreateFloor < ActiveRecord::Migration[5.0]
  def change
    create_table :floors do |t|
      t.string :name
    end
  end
end
