class AppointmentsController < ApplicationController
  def index
    Appointment.all.to_json
  end
end
