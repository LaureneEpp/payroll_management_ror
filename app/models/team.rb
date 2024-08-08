class Team < ApplicationRecord
    has_many :employees
    belongs_to :department
    belongs_to :leader, class_name: 'Employee', foreign_key: 'user_id', optional: true

    validates :name, uniqueness: true


    def update_leader_roles(new_leader_id, previous_leader_id = nil)
        User.find(new_leader_id).update(role: 'manager')
        if previous_leader_id && previous_leader_id != new_leader_id
          User.find(previous_leader_id).update(role: 'standard')
        end
    end
end
