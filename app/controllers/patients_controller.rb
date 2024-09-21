class PatientsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_patient, only: [:show, :edit, :update, :destroy]
    before_action :authorize_receptionist!, only: [:new, :create, :edit, :update, :destroy]
    before_action :authorize_doctor!, only: [:doctor_index, :stats]
  
    # Index action for receptionists
    def index
        @patients = Patient.all
        if params[:search].present?
          @patients = @patients.where("name ILIKE ?", "%#{params[:search]}%")
        end
    end
  
    # Doctor's view of registered patients
    def doctor_index
      @patients = Patient.all
    end
  
    # Show a specific patient
    def show; end
  
    # New patient form
    def new
      @patient = Patient.new
    end
  
    # Create a new patient
    def create
      @patient = Patient.new(patient_params)
      if @patient.save
        redirect_to @patient, notice: 'Patient was successfully created.'
      else
        render :new
      end
    end
  
    # Edit a specific patient
    def edit; end
  
    # Update a specific patient
    def update
      if @patient.update(patient_params)
        redirect_to @patient, notice: 'Patient was successfully updated.'
      else
        render :edit
      end
    end
  
    # Destroy a specific patient
    def destroy
      @patient.destroy
      redirect_to patients_url, notice: 'Patient was successfully destroyed.'
    end
  
    # Patient registration statistics for doctors
    def stats
      @patient_count = Patient.group_by_day(:created_at).count
    end
  
    private
  
    # Set patient for certain actions
    def set_patient
        if params[:id].present? && params[:action] != 'stats'
          @patient = Patient.find(params[:id])
        end
    end
  
    # Strong parameters for patient
    def patient_params
      params.require(:patient).permit(:name, :age, :gender)
    end
  
    # Authorize receptionist actions
    def authorize_receptionist!
      redirect_to root_path, alert: 'Not authorized!' unless current_user.receptionist?
    end
  
    # Authorize doctor actions
    def authorize_doctor!
      redirect_to root_path, alert: 'Not authorized!' unless current_user.doctor?
    end
  end
  
