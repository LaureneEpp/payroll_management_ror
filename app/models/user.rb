class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
 after_initialize :set_default_role, if: :new_record?

  has_one :employee, dependent: :destroy
  accepts_nested_attributes_for :employee, allow_destroy: true, update_only: true
  
  protected 

  enum role: [:standard, :manager, :admin]

 def set_default_role
   self.role ||= :standard
 end

end