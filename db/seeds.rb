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
    t.say_status "Emails / mo", plan_attributes[:number_of_bundled_emails], :blue
    t.say_status "Cost / Email", sprintf("$%.3f", plan_attributes[:overage_email_cost]), :blue
    t.say_status "Cost / SMS", sprintf("$%.3f", plan_attributes[:sms_cost]), :blue
    Plan.create! name: plan_attributes[:name],
                 number_of_bundled_emails: plan_attributes[:number_of_bundled_emails],
                 monthly_cost: plan_attributes[:monthly_cost],
                 overage_email_cost: plan_attributes[:overage_email_cost],
                 sms_cost: plan_attributes[:sms_cost]
  end
end