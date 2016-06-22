require 'rails_helper'

RSpec.describe Reminder, type: :model do
  describe 'state_machine' do
    let(:disabled_reminder) { FactoryGirl.create(:reminder, state: :disabled) }

    describe '#activate' do
      it { expect { disabled_reminder.activate }.to change{ Reminder.active.size }.from(0).to(1) }
      it { expect(subject.activate).to be_falsey }
    end

    describe '#disable' do
      it { expect { subject.disable} .to change{ Reminder.disabled.size }.from(0).to(1) }
      it { expect(disabled_reminder.disable).to be_falsey }
    end
  end
end
