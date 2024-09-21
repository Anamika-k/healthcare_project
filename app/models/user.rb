class User < ApplicationRecord
  has_many :doctor_appointments, class_name: 'Appointment', foreign_key: :doctor_id
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: { receptionist: 0, doctor: 1 }

end
