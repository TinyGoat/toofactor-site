class AddNextBillingDateToUsers < ActiveRecord::Migration
  def change
    add_column :users, :next_billing_date, :date
  end
end
