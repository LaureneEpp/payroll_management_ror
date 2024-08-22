class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
 
  enum role: { standard: 0, manager: 1, admin: 2 }
  after_initialize :set_default_role, if: :new_record?

  has_one :employee, dependent: :destroy
  has_many :led_teams, class_name: 'Team', foreign_key: 'user_id'
  accepts_nested_attributes_for :employee, allow_destroy: true, update_only: true
  
  protected 


  def set_default_role
    self.role ||= :standard
  end
end