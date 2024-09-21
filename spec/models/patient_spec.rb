require 'rails_helper'

RSpec.describe Patient, type: :model do
    it "is valid with valid attributes" do
        patient = Patient.new(name: 'John Doe', age: 30, gender: 'Male')
        expect(patient).to be_valid
    end

    it "is not valid without name" do
        patient = Patient.new(age: 30, gender: 'Male')
        expect(patient).not_to be_valid
    end  

    it "is not valid without age" do
        patient = Patient.new(name: 'John Doe', gender: 'Male')
        expect(patient).not_to be_valid
    end

    it "is not valid without gender" do
        patient = Patient.new(name: 'John Doe', age: 30)
        expect(patient).not_to be_valid
    end
end