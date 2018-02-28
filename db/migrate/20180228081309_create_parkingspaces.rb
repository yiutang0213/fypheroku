class CreateParkingspaces < ActiveRecord::Migration[5.1]
  def change
    create_table :parkingspaces do |t|
      t.integer :venue_id
      t.string :parkingspace_no
      t.boolean :parkingspace_status

      t.timestamps
    end
  end
end
