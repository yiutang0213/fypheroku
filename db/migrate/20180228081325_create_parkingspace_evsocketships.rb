class CreateParkingspaceEvsocketships < ActiveRecord::Migration[5.1]
  def change
    create_table :parkingspace_evsocketships do |t|
      t.integer :evsocket_id
      t.integer :parkingspace_id

      t.timestamps
    end
  end
end
