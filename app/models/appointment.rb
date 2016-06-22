class Appointment < ActiveRecord::Base
  belongs_to :creator, class_name: "User"
  has_many :reminders

  scope :past, -> { where("start_time < ?", Time.now)  }
  scope :upcoming, -> { where("start_time > ?", Time.now)  }
  scope :ongoing, -> { where(start_time: (Time.now - 1.hour)..(Time.now))  }
  scope :active, -> { where(state: :active)  }
  scope :disabled, -> { where(state: :disabled)  }

  state_machine :state, initial: :active do
    event :disable do
      transition active: :disabled
    end
    event :activate do
      transition disabled: :active
    end
  end
end
