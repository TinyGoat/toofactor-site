Fabricator(:plan) do
  name { sequence(:name) { |n| "Plan #{n}" } }
  monthly_cost { rand(150) }
  number_of_bundled_emails { rand(100000) }
  overage_email_cost { rand(99).truncate * 0.001 }
  sms_cost { rand(99).truncate * 0.01 }
end
