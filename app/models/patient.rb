class Patient < ApplicationRecord
    has_many :appointments
    validates :name, presence: true
    validates :age, presence: true
    validates :gender, presence: true
end
