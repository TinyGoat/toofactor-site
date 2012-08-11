Fabricator(:plan) do
  name { sequence(:name) { |n| "Plan #{n}" } }
  monthly_cost { rand(150) }
  number_of_bundled_sms { rand(10000) }
  overage_sms_cost { rand(99).truncate * 0.001 }
end
