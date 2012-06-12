class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email,
                  :password,
                  :password_confirmation,
                  :remember_me,
                  :api_key,
                  :next_billing_date,
                  :stripe_card_token,
                  :plan_id

  attr_accessor :stripe_card_token,
                :plan_id


  ##
  ## Relationships
  ##

  has_one :subscription
  has_one :plan, through: :subscription


  ##
  ## Validations
  ##

  validates :email, presence: true, uniqueness: true
  validates :next_billing_date, presence: true
  validates :api_key, presence: true, uniqueness: true


  ##
  ## Callbacks
  ##

  before_validation :validate_plan_id
  before_validation :generate_api_keys, on: :create
  before_validation :set_next_billing_date, on: :create
  after_create :notify_redis_of_new_api_keys
  before_validation :generate_stripe_customer_token
  after_save :create_subscription_from_plan_id


  private
  
  def create_subscription_from_plan_id
    self.subscription = Subscription.create(plan_id: self.plan_id)
  end
  
  def validate_plan_id
    if plan_id.blank?
      errors.add :plan_id, "You must select a plan to register."
      false
    elsif !Plan.exists?(plan_id)
      errors.add :plan_id, "Please select a valid plan to register."
      false
    else
      true
    end
  end
  
  def generate_api_keys
    self.api_key = (Digest::RMD160.new << self.email + API_KEY_SALT).to_s
    self.dev_api_key = (Digest::RMD160.new << self.email + DEV_API_KEY_SALT).to_s
  end
  
  def notify_redis_of_new_api_keys
    $CUSTOMER_REDIS.set(self.api_key, '0')
    $CUSTOMER_DEV_REDIS.set(self.dev_api_key, '0')
  end

  def set_next_billing_date
    self.next_billing_date = 15.days.from_now
  end
  
  def generate_stripe_customer_token
    unless self.stripe_card_token.blank?
      customer = Stripe::Customer.create(description: email, card: stripe_card_token)
      self.stripe_customer_token = customer.id
      self.stripe_card_token = nil
      save!
    end
  rescue Stripe::InvalidRequestError => e
    logger.error "Stripe error while creating customer: #{e.message}"
    errors.add :base, "There was a problem with your credit card."
    false
  end

end
