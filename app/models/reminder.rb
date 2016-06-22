class Reminder < ActiveRecord::Base
  belongs_to :appointment
  scope :active, -> { where(state: :active) }
  scope :canceled, -> { where(state: :canceled) }

  state_machine :state, initial: :active do
    event :cancel do
      transition active: :canceled
    end
    event :activate do
      transition canceled: :active
    end
  end
end
