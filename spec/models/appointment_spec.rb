require 'rails_helper'

describe Appointment, type: :model do
  let(:disabled_appointment) { FactoryGirl.create(:appointment, state: :canceled) }
  let(:active_appointment) { FactoryGirl.create(:appointment, state: :active) }

  it 'searches for future appointments' do
    FactoryGirl.create(:future_appointment)
    FactoryGirl.create(:past_appointment)
    expect(Appointment.upcoming.size).to eq 1
  end
  it 'searches for past appointments' do
    FactoryGirl.create(:future_appointment)
    FactoryGirl.create(:past_appointment)
    expect(Appointment.past.size).to eq 1
  end

  context 'when appointment started 59 minutes before' do
    it 'founds in as an ongoing appointments' do
      FactoryGirl.create(:appointment, start_time: Time.now - 59.minutes)
      expect(Appointment.ongoing.size).to eq 1
    end
  end

  context 'when appointment started right now' do
    it 'founds in as an ongoing appointments' do
      FactoryGirl.create(:appointment, start_time: Time.now)
      expect(Appointment.ongoing.size).to eq 1
    end
  end

  context 'when appointment will start one minute later' do
    it 'founds in as an ongoing appointments' do
      FactoryGirl.create(:appointment, start_time: Time.now + 1.minute)
      expect(Appointment.ongoing.size).to eq 0
    end
  end

  it 'creates active by default' do
    FactoryGirl.create(:appointment)
    expect(Appointment.active.size).to eq 1
  end

  describe ".at_date" do
    it "finds appointments in specific day" do
      FactoryGirl.create(:appointment, start_time: Time.now + 2.days)
      FactoryGirl.create(:appointment, start_time: Time.now + 1.days)
      expect(Appointment.at_date(Time.now + 2.days).count).to eq 1
    end
  end

  describe 'state_machine' do
    describe '#activate' do
      it { expect { disabled_appointment.activate }.to change{ Appointment.active.count }.from(0).to(1) }
      it { expect(active_appointment.activate).to be_falsey }
    end

    describe '#cancel' do
      it { expect { active_appointment.cancel} .to change{ Appointment.canceled.count }.from(0).to(1) }
      it { expect(disabled_appointment.cancel).to be_falsey }
    end
  end

  describe "relations specific code" do
    it "removes related reminders when removed" do
      FactoryGirl.create_list(:reminder, 3, appointment: active_appointment)
      expect { active_appointment.destroy }.to change{ Reminder.count }.from(3).to(0)
    end

    it "removes related reminders when removed" do
      FactoryGirl.create_list(:reminder, 3, appointment: active_appointment)
      expect { active_appointment.cancel }.to change{ Reminder.active.count }.from(3).to(0)
    end
  end

  describe ".appointment_arent_overlapped" do
    it 'doesn\'t allow to create overlapped appointments' do
      FactoryGirl.create(:ongoing_appointment)
      expect(FactoryGirl.build(:appointment, start_time: Time.now + 57.minutes).valid?).to be_falsey
    end

    it 'allows to create not overlapped appointments' do
      FactoryGirl.create(:ongoing_appointment)
      expect(FactoryGirl.build(:appointment, start_time: Time.now + 3.hours).valid?).to be_truthy
    end
  end
end
