class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
 after_initialize :set_default_role, if: :new_record?

  has_one :employee, dependent: :destroy
  has_many :led_teams, class_name: 'Team', foreign_key: 'user_id'
  accepts_nested_attributes_for :employee, allow_destroy: true, update_only: true
  
  protected 

  enum role: [:standard, :manager, :admin]

 def set_default_role
   self.role ||= :standard
 end

end