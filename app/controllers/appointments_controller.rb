class AppointmentsController < ApplicationController
  def index
    render json: Appointment.all.to_json
  end
end
