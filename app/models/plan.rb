class Plan < ActiveRecord::Base

  attr_accessible :name,
                  :monthly_cost,
                  :number_of_bundled_sms,
                  :overage_sms_cost

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
  validates :number_of_bundled_sms, presence: true
  validates :overage_sms_cost, presence: true


  ##
  ## Instance Methods
  ##
  
  def name_with_monthly_cost
    "#{self.name} ($#{self.monthly_cost.to_i} / mo)"
  end

end
