FactoryGirl.define do
  factory :appointment do
    title Faker::Lorem.sentence(3)
    start_time Faker::Time.forward
    creator

    factory :past_appointment do
      start_time Faker::Time.backward
    end

    factory :future_appointment do
      start_time Faker::Time.forward
    end

    factory :ongoing_appointment do
      start_time { Time.now }
    end
  end
end
