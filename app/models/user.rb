class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
 after_initialize :set_default_role, if: :new_record?


  has_one :employee, dependent: :destroy
  accepts_nested_attributes_for :employee, allow_destroy: true, update_only: true
  
  enum role: [:user, :manager, :admin]

  
 def set_default_role
   self.role ||= :user
 end

end