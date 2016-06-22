require 'rails_helper'

describe Appointment, type: :model do
  it 'searches for future appointments' do
    FactoryGirl.create_list(:future_appointment, 2)
    FactoryGirl.create(:past_appointment)
    expect(Appointment.upcoming.size).to eq 2
  end
  it 'searches for past appointments' do
    FactoryGirl.create(:future_appointment)
    FactoryGirl.create_list(:past_appointment, 2)
    expect(Appointment.past.size).to eq 2
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

  it 'doesn\'t allow to create overlapped appointments' do
    FactoryGirl.create(:ongoing_appointment)
    expect(FactoryGirl.create(:appointment, start_time: Time.now + 57.minutes)).to be_falsey
  end

  describe ".at_date" do
    it "finds appointments in specific day" do
      FactoryGirl.create_list(:appointment, 2, start_time: Time.now + 2.days)
      FactoryGirl.create(:appointment, start_time: Time.now + 1.days)
      expect(Appointment.at_date(Time.now + 2.days).count).to eq 2
    end
  end

  describe 'state_machine' do
    let(:disabled_appointment) { FactoryGirl.create(:appointment, state: :canceled) }

    describe '#activate' do
      it { expect { disabled_appointment.activate }.to change{ Appointment.active.count }.from(0).to(1) }
      it { expect(subject.activate).to be_falsey }
    end

    describe '#cancel' do
      it { expect { subject.cancel} .to change{ Appointment.canceled.count }.from(0).to(1) }
      it { expect(disabled_appointment.cancel).to be_falsey }
    end
  end

  describe "relations specific code" do
    it "removes related reminders when removed" do
      FactoryGirl.create_list(:reminder, 3, appointment: subject)
      expect { subject.destroy }.to change{ Reminder.count }.from(3).to(0)
    end

    it "removes related reminders when removed" do
      FactoryGirl.create_list(:reminder, 3, appointment: subject)
      expect { subject.cancel }.to change{ Reminder.active.count }.from(3).to(0)
    end
  end
end
