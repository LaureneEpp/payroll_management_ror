require 'faker'

# Clear existing data
Employee.delete_all
User.delete_all
Position.delete_all
Team.delete_all
Department.delete_all

puts "🌱 Seeding..."

# Create Departments
Department.create(name: 'TBD')
10.times { Department.create(name: Faker::Company.department) }
puts "#{Department.count} departments have been created."

# Create Positions
10.times { Position.create!(name: Faker::Company.profession) }
puts "#{Position.count} positions have been created."

# Create Users
users = []
20.times do
  user = User.create!(
    email: Faker::Internet.email,
    password: 'password',
    password_confirmation: 'password',
    role: 0 # default role for regular users
  )
  users << user
end
puts "#{User.count} users have been created."

# Create Teams
teams = []
managers = []
10.times do
  manager = User.create!(
    email: Faker::Internet.email,
    password: 'password',
    password_confirmation: 'password',
    role: 1 # default role for regular users
  )
  managers << manager
end
puts "#{User.count} managers have been created."

10.times do
  department_id = Department.pluck(:id).sample

  # Find a user who is not already a manager of another team
  leader_user = managers.detect { |user| Team.where(user_id: user.id).none? }

  if leader_user
    
      team = Team.create!(
        name: Faker::Lorem.unique.word,  # Ensure unique team name
        description: Faker::Lorem.sentence(word_count: 3),
        department_id: department_id,
        user_id: leader_user.id
      )
      if team.persisted?
        teams << team
        puts "Team '#{team.name}' created with leader user '#{leader_user.email}'."
      else
        puts "Failed to create team: #{e.message}"
      end
  else
    # Create a team without a leader if no eligible user is found
    team = Team.create!(
      name: Faker::Lorem.unique.word,  # Ensure unique team name
      description: Faker::Lorem.sentence(word_count: 3),
      department_id: department_id,
      user_id: nil
    )
    teams << team
    puts "Team '#{team.name}' created without a leader."
  end
end

puts "#{Team.count} teams have been created."

# Create Admin User
admin_user = User.create!(
  username: "admin",
  email: "admin@admin.org",
  password: 'password',
  password_confirmation: 'password',
  role: 2 # role for admin or manager
)
puts "Admin user created with email '#{admin_user.email}'"

# Create the TBD team with the admin as the leader
tbd_team = Team.create!(
  name: 'TBD',
  description: 'Abc',
  department_id: Department.first.id,
  user_id: admin_user.id
)

Employee.create!(
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  email: admin_user.email,
  team_id: tbd_team.id,
  position_id: Position.pluck(:id).sample,
  city: Faker::Address.city,
  country: Faker::Address.country,
  user: admin_user
)
puts "Admin user associated with the TBD team."

# Create Employees
10.times do
  team_id = teams.sample.id
  position_id = Position.pluck(:id).sample
  user = User.create!(
    email: Faker::Internet.email,
    password: 'password',
    password_confirmation: 'password'
  )
  employee = Employee.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: user.email,
    team_id: team_id,
    position_id: position_id,
    city: Faker::Address.city,
    country: Faker::Address.country,
    user: user
  )
  puts "Employee '#{employee.first_name} #{employee.last_name}' created with user '#{user.email}'."
end
puts "#{Employee.count} employees have been created."

puts "✅ Done seeding!"
