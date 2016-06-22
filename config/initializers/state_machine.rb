# Rails 4.1.0.rc1 and StateMachine don't play nice
# https://github.com/pluginaweek/state_machine/issues/295

require 'state_machine/version'

module StateMachine::Integrations::ActiveModel
  public :around_validation
end
