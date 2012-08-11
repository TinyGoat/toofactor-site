class ChangeFieldsForPlans < ActiveRecord::Migration
  def change
    add_column :plans, :number_of_bundled_sms, :integer
    rename_column :plans, :sms_cost, :overage_sms_cost
    remove_column :plans, :overage_email_cost
    remove_column :plans, :number_of_bundled_emails 
  end
end
