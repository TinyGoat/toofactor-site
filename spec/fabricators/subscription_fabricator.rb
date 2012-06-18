Fabricator(:subscription) do
  subscribed_at { rand(365).days.ago }
  canceled_at { nil }
  plan!
  user
end

Fabricator(:canceled_subscription, :from => :subscription) do
  canceled_at do |sub|
    [sub.subscribed_at + 120.days,Time.now].min
  end
end
