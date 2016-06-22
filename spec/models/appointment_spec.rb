require 'rails_helper'

describe Appointment, type: :model do
  it "searches for future appointments" do
    FactoryGirl.create_list(:future_appointment, 2)
    FactoryGirl.create(:past_appointment)
    expect(Appointment.upcoming.size).to eq 2
  end
  it "searches for past appointments" do
    FactoryGirl.create(:future_appointment)
    FactoryGirl.create_list(:past_appointment, 2)
    expect(Appointment.past.size).to eq 2
  end

  context "when appointment started 59 minutes before" do
    it "founds in as an ongoing appointments" do
      FactoryGirl.create(:appointment, start_time: Time.now - 59.minutes)
      expect(Appointment.ongoing.size).to eq 1
    end
  end

  context "when appointment started right now" do
    it "founds in as an ongoing appointments" do
      FactoryGirl.create(:appointment, start_time: Time.now)
      expect(Appointment.ongoing.size).to eq 1
    end
  end

  context "when appointment will start one minute later" do
    it "founds in as an ongoing appointments" do
      FactoryGirl.create(:appointment, start_time: Time.now + 1.minute)
      expect(Appointment.ongoing.size).to eq 0
    end
  end
end
