class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.datetime :start_time
      t.string :title
      t.integer :creator_id, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
