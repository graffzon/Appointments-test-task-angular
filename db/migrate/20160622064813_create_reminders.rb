class CreateReminders < ActiveRecord::Migration
  def change
    create_table :reminders do |t|
      t.references :appointment, index: true, foreign_key: true
      t.datetime :remind_at

      t.timestamps null: false
    end
  end
end
