class Appointment < ActiveRecord::Base
  DEFAULT_APPOINTMENT_DURATION = 1.hour

  belongs_to :creator, class_name: 'User'
  has_many :reminders, dependent: :destroy

  validates :start_time, presence: true
  validates :title, presence: true
  validate :appointment_arent_overlapped, on: :create

  scope :past, -> { where('start_time < ?', Time.now) }
  scope :upcoming, -> { where('start_time > ?', Time.now) }
  scope :ongoing, -> { where(start_time: (Time.now - DEFAULT_APPOINTMENT_DURATION)..(Time.now)) }
  scope :active, -> { where(state: :active) }
  scope :canceled, -> { where(state: :canceled) }
  scope :at_date, -> (date) { where(start_time: (date.midnight..(date.midnight + 1.day))) }

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

  private

  def appointment_arent_overlapped
    unless Appointment.where(start_time: (start_time - 1.hour)..(start_time + 1.hour)).empty?
      errors.add(:start_time, 'Cannot be overlapped with another appointments')
    end
  end
end
