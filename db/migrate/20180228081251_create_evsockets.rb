class CreateEvsockets < ActiveRecord::Migration[5.1]
  def change
    create_table :evsockets do |t|
    		t.string :evsocket_code
			t.boolean :evsocket_status
			t.integer :evsocket_type
			t.integer :venue_id

      t.timestamps
    end
  end
end
