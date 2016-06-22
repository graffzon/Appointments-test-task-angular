FactoryGirl.define do
  factory :reminder do
    appointment(start_time: Faker::Time.forward(10))
    remind_at Faker::Time.forward(9)
  end
end
