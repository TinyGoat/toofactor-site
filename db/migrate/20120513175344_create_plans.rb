class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.string :name
      t.float :monthly_cost
      t.integer :number_of_bundled_emails
      t.float :overage_email_cost
      t.float :sms_cost
      t.timestamps
    end
  end
end
