class CreateVenues < ActiveRecord::Migration[5.1]
  def change
    create_table :venues do |t|
      t.string :name
      t.text :address
      t.float :charger_fee
      t.float :parking_fee
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
