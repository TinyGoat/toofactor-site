Fabricator(:user) do
  email { Faker::Internet.email }
  password { 'password!' }
  password_confirmation { 'password!' }
  after_build do |user|
    user.plan_id = Fabricate(:subscription, user: user).plan.id
  end
end
