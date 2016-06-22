class AddStateToReminder < ActiveRecord::Migration
  def change
    add_column :reminders, :state, :string
  end
end
