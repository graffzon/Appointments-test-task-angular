FactoryGirl.define do
  factory :user, aliases: [:creator] do
    email { Faker::Internet.email }
    password "password"
    password_confirmation "password"
  end
end
