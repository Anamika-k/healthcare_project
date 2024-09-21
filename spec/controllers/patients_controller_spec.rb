require 'rails_helper'

RSpec.describe PatientsController, type: :controller do
  let(:receptionist) { create(:user, :receptionist) }
  let(:doctor) { create(:user, :doctor) }
  let(:valid_attributes) { { name: "John Doe", age: 30, gender: "Male" } }
  let(:invalid_attributes) { { name: nil, age: 30, gender: "Male" } }
  let!(:patient) { create(:patient, valid_attributes) }

  describe "GET #index" do
    before do
      sign_in receptionist
    end

    it "returns a success response" do
      get :index
      expect(response).to be_successful
    end

    it "assigns @patients" do
      get :index
      expect(assigns(:patients)).to include(patient)
    end

    it "returns filtered patients when a search parameter is present" do
      get :index, params: { search: "John" }
      expect(assigns(:patients)).to include(patient)
    end
  end

  describe "GET #doctor_index" do
    before do
      sign_in doctor
    end

    it "returns a success response" do
      get :doctor_index
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      get :show, params: { id: patient.to_param }
      expect(response).to be_successful
    end
  end

  describe "GET #new" do
    before do
      sign_in receptionist
    end

    it "returns a success response" do
      get :new
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    before do
      sign_in receptionist
    end

    context "with valid params" do
      it "creates a new Patient" do
        expect {
          post :create, params: { patient: valid_attributes }
        }.to change(Patient, :count).by(1)
      end

      it "redirects to the created patient" do
        post :create, params: { patient: valid_attributes }
        expect(response).to redirect_to(Patient.last)
      end
    end

    context "with invalid params" do
      it "does not create a new Patient" do
        expect {
          post :create, params: { patient: invalid_attributes }
        }.to change(Patient, :count).by(0)
      end

      it "renders the new template" do
        post :create, params: { patient: invalid_attributes }
        expect(response).to render_template(:new)
      end
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      get :edit, params: { id: patient.to_param }
      expect(response).to be_successful
    end
  end

  describe "PATCH #update" do
    before do
      sign_in receptionist
    end

    context "with valid params" do
      let(:new_attributes) { { name: "Jane Doe" } }

      it "updates the requested patient" do
        patch :update, params: { id: patient.to_param, patient: new_attributes }
        patient.reload
        expect(patient.name).to eq("Jane Doe")
      end

      it "redirects to the patient" do
        patch :update, params: { id: patient.to_param, patient: new_attributes }
        expect(response).to redirect_to(patient)
      end
    end

    context "with invalid params" do
      it "does not update the patient" do
        patch :update, 
