class Team < ApplicationRecord
    has_many :employees
    belongs_to :department
    belongs_to :leader, class_name: 'Employee', foreign_key: 'user_id', optional: true

    validates :name, uniqueness: true
    validate :unique_manager_per_team

    def update_leader_roles(new_leader_id, previous_leader_id = nil)
        User.find(new_leader_id).update(role: 'manager')
        if previous_leader_id && previous_leader_id != new_leader_id
          User.find(previous_leader_id).update(role: 'standard')
        end
    end
    
    private

    def unique_manager_per_team
        if Team.where(user_id: leader) .exists? && user_id != self.user_id
          errors.add(:user_id, 'is already a manager of another team')
        end
    end
end
