module TeamsHelper
  # def update_leader_roles(new_leader_id, previous_leader_id)
  #   # Promote the new leader to 'manager'
  #   User.find(new_leader_id).update(role: 'manager')

  #   # Demote the previous leader back to 'employee', if different
  #   if previous_leader_id && previous_leader_id != new_leader_id
  #     User.find(previous_leader_id).update(role: 'employee')
  #   end
  # end
end
