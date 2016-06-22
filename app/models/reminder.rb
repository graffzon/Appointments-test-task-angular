class Reminder < ActiveRecord::Base
  belongs_to :appointment
  scope :active, -> { where(state: :active) }
  scope :disabled, -> { where(state: :disabled) }

  state_machine :state, initial: :active do
    event :disable do
      transition active: :disabled
    end
    event :activate do
      transition disabled: :active
    end
  end
end
