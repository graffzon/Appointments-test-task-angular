class AppointmentsController < ApplicationController
  def index
    render json: Appointment.all.to_json
  end

  def create
    appointment = Appointment.new(appointment_params)
    if appointment.save
      render json: appointment
    else
      render json: {error: appointment.errors}
    end
  end

  private

  def appointment_params
    params.require(:appointment).permit(:title, :start_time)
  end
end
