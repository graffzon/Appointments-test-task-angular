FactoryGirl.define do
  factory :reminder do
    appointment
    remind_at Faker::Time.forward(9)
  end
end
