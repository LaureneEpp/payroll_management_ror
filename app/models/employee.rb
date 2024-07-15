class Employee < ApplicationRecord
    belongs_to :team, optional: true
    has_many :payslip
  
    has_one :departement, through: :team
    belongs_to :position, optional: true
  
    has_one_attached :avatar
    after_commit :add_default_avatar, on: %i[create update]
  
    before_validation :set_default_values
end
