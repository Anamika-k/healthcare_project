class Appointment < ApplicationRecord
  belongs_to :patient
  belongs_to :doctor, class_name: 'User'
end
