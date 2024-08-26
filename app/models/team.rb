class Team < ApplicationRecord
    has_many :employees
    belongs_to :department
    belongs_to :leader, class_name: 'User', foreign_key: 'user_id', optional: true

    validates :name, uniqueness: true
    validate :unique_manager_per_team
    validate :manager_role_required
    
    private

    def unique_manager_per_team
      if Team.where(user_id: user_id).where.not(id: id).exists?
        errors.add(:user_id, 'is already a manager of another team')
      end
    end

    def manager_role_required
      return unless user_id.present?
  
      user = User.find(user_id)
      unless user.manager? || user.admin?
        errors.add(:user_id, 'selected does not have a manager role.')
      end
    end

end