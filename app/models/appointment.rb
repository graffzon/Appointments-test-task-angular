class Appointment < ActiveRecord::Base
  belongs_to :creator, class_name: 'User'
  has_many :reminders, dependent: :destroy

  scope :past, -> { where('start_time < ?', Time.now) }
  scope :upcoming, -> { where('start_time > ?', Time.now) }
  scope :ongoing, -> { where(start_time: (Time.now - 1.hour)..(Time.now)) }
  scope :active, -> { where(state: :active) }
  scope :canceled, -> { where(state: :canceled) }

  state_machine :state, initial: :active do
    event :cancel do
      transition active: :canceled
    end
    event :activate do
      transition canceled: :active
    end

    after_transition any => :canceled do |appointment|
      appointment.reminders.each(&:cancel)
    end
  end
end
