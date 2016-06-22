require 'rails_helper'

RSpec.describe Reminder, type: :model do
  describe 'state_machine' do
    let(:disabled_reminder) { FactoryGirl.create(:reminder, state: :canceled) }

    describe '#activate' do
      it { expect { disabled_reminder.activate }.to change{ Reminder.active.count }.from(0).to(1) }
      it { expect(subject.activate).to be_falsey }
    end

    describe '#cancel' do
      it { expect { subject.cancel} .to change{ Reminder.canceled.count }.from(0).to(1) }
      it { expect(disabled_reminder.cancel).to be_falsey }
    end
  end
end
