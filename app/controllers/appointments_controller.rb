class AppointmentsController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_receptionist!, only: [:new, :create]
    before_action :set_appointment, only: [:show, :edit, :update, :destroy]
  
    def index
      @appointments = Appointment.includes(:patient).all
    end
  
    def new
      @appointment = Appointment.new
      @patients = Patient.all
      @doctors = User.where(role: :doctor)
    end
  
    def create
      @appointment = Appointment.new(appointment_params)
      if @appointment.save
        redirect_to appointments_path, notice: 'Appointment was successfully created.'
      else
        @patients = Patient.all
        @doctors = User.where(role: :doctor)
        render :new
      end
    end
  
    def show; end
  
    private
  
    def set_appointment
      @appointment = Appointment.find(params[:id])
    end
  
    def appointment_params
      params.require(:appointment).permit(:patient_id, :doctor_id, :date, :notes)
    end
  
    def authorize_receptionist!
      redirect_to root_path, alert: 'Not authorized!' unless current_user.receptionist?
    end
  end
  
