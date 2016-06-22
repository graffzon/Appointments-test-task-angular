class Appointment < ActiveRecord::Base
  belongs_to :creator, class_name: "User"
  has_many :reminders

  scope :past, -> { where("start_time < ?", Time.now)  }
  scope :upcoming, -> { where("start_time > ?", Time.now)  }
  scope :ongoing, -> { where(start_time: (Time.now - 1.hour)..(Time.now))  }
end
