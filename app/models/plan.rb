class Plan < ActiveRecord::Base

  attr_accessible :name,
                  :monthly_cost,
                  :number_of_bundled_emails,
                  :overage_email_cost,
                  :sms_cost

  ##
  ## Relationships
  ##

  has_many :subscriptions
  has_many :users, through: :subscriptions


  ##
  ## Validations
  ##

  validates :name, presence: true, uniqueness: true
  validates :monthly_cost, presence: true
  validates :number_of_bundled_emails, presence: true
  validates :overage_email_cost, presence: true
  validates :sms_cost, presence: true


  ##
  ## Instance Methods
  ##
  
  def name_with_monthly_cost
    "#{self.name} ($#{self.monthly_cost.to_i} / mo)"
  end

end
