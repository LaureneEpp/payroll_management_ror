class Team < ApplicationRecord
    has_many :employees
    belongs_to :department
    belongs_to :leader, class_name: 'Employee', foreign_key: 'user_id', optional: true

    validates :name, uniqueness: true
    validate :unique_manager_per_team

    def update_leader_roles(new_leader_id, previous_leader_id = nil)
      User.find(new_leader_id).update(role: 1) 
      if previous_leader_id && previous_leader_id != new_leader_id
        previous_leader = User.find(previous_leader_id)
        unless Team.exists?(user_id: previous_leader.id)
          previous_leader.update(role: 0)
        end
      end
    end
    
    private

    def unique_manager_per_team
      if Team.where(user_id: user_id).where.not(id: id).exists?
        errors.add(:user_id, 'is already a manager of another team')
      end
    end
end

