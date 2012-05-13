class Plan < ActiveRecord::Base

  attr_accessible :name,
                  :monthly_cost,
                  :number_of_bundled_emails,
                  :overage_email_cost,
                  :sms_cost


  ##
  ## Validations
  ##

  validates :name, presence: true, uniqueness: true
  validates :monthly_cost, presence: true
  validates :number_of_bundled_emails, presence: true
  validates :overage_email_cost, presence: true
  validates :sms_cost, presence: true

end
