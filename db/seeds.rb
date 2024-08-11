# Clear existing data
require 'faker'

# Ensure data deletion respects foreign key constraints
# PayslipAllowance.delete_all
# PayslipDeduction.delete_all
Payslip.delete_all
Employee.delete_all
User.delete_all
Allowance.delete_all
Deduction.delete_all
Position.delete_all
Team.delete_all
Department.delete_all

puts "🌱 Seeding..."

# Create Departments
Department.create(name: 'TBD')
10.times { Department.create(name: Faker::Company.department) }
puts "#{Department.count} departments have been created."

# Create Teams
Team.create(name: 'TBD', description: 'Abc', department_id: Department.first.id)
10.times do
  department_id = Department.pluck(:id).sample
  team = Team.create(
    name: Faker::Lorem.word,
    description: Faker::Lorem.sentence(word_count: 3),
    department_id: department_id
  )
  puts "Team '#{team.name}' created"
end
puts "#{Team.count} teams have been created."

# Create Positions
10.times { Position.create!(name: Faker::Company.profession) }
puts "#{Position.count} positions have been created."


1.times do
  team_id = Team.pluck(:id).sample
  position_id = Position.pluck(:id).sample
  user = User.create!(
    username: "admin",
    email: "admin@admin.org",
    password: 'password',
    password_confirmation: 'password', 
    role: 'admin'
  )
   Employee.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: user.email,
    team_id: team_id,
    position_id: position_id,
    city: Faker::Address.city,
    country: Faker::Address.country,
    user: user
  )
  puts "Admin user created with user '#{user.email}'"
end

# Create Employees
10.times do
  team_id = Team.pluck(:id).sample
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
  puts "Employee '#{employee.first_name} #{employee.last_name}' created with user '#{user.email}'"
end
puts "#{Employee.count} employees have been created."

# Create Allowances
# 10.times do
#   allowance = Allowance.create(
#     name: Faker::Lorem.word,
#     description: Faker::Lorem.sentence(word_count: 3),
#     amount: rand(1..500)
#   )
#   puts "Allowance '#{allowance.name}' created"
# end
# puts "#{Allowance.count} allowances have been created."

# Create Deductions
# 10.times do
#   deduction = Deduction.create(
#     name: Faker::Lorem.word,
#     description: Faker::Lorem.sentence(word_count: 3),
#     amount: rand(1..500)
#   )
#   puts "Deduction '#{deduction.name}' created"
# end
# puts "#{Deduction.count} deductions have been created."

puts "✅ Done seeding!"