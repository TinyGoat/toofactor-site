Fabricator(:user, aliases: [:active_user]) do
  email { Faker::Internet.email }
  password { 'password!' }
  password_confirmation { 'password!' }
  after_build do |user|
    user.plan_id = Fabricate(:subscription, user: user).plan.id
  end
end

Fabricator(:inactive_user, from: :user) do
  after_create do |user|
    user.subscription.terminate!
  end
end