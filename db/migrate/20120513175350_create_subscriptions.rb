class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.references :plan
      t.references :user
      t.datetime :subscribed_at
      t.datetime :canceled_at
      t.timestamps
    end
  end
end
