require 'thor'
require 'yaml'

t = Thor::Shell::Color.new

unless Plan.any?
  t.say_status "creating", "Plans"
  file_path = Rails.root.join('db','seed_data','plans.yml')
  plans_from_yaml = HashWithIndifferentAccess.new(YAML.load(IO.read(file_path)))
  for plan_attributes in plans_from_yaml[:plans] do
    t.say_status plan_attributes[:name], "", :white
    t.say_status "Monthly Cost", sprintf("$%.2f", plan_attributes[:monthly_cost]), :blue
    t.say_status "SMS / mo.", plan_attributes[:number_of_bundled_sms], :blue
    t.say_status "Overage Cost", sprintf("$%.3f", plan_attributes[:overage_sms_cost]), :blue
    Plan.create! name: plan_attributes[:name],
                 number_of_bundled_sms: plan_attributes[:number_of_bundled_sms],
                 monthly_cost: plan_attributes[:monthly_cost],
                 overage_sms_cost: plan_attributes[:overage_sms_cost]
  end
end

unless Rails.env.production?
  
  unless User.any?
    
    puts "\n"
    t.say_status "creating", "Test User"
    user = Fabricate.build(:user, email: 'user@example.com',
                                  password: 'password!',
                                  password_confirmation: 'password!')
    t.say_status "email", user.email, :blue
    t.say_status "password", 'password!', :blue
    user.save!
    user.confirm!
  end
  
end