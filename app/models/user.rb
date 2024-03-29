class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable

  # Requires
  require 'OpenSSL'
  require 'Base64'
  
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email,
                  :password,
                  :password_confirmation,
                  :remember_me,
                  :api_key,
                  :next_billing_date,
                  :stripe_card_token,
                  :plan_id,
                  :subscription_id

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
  validates :plan_id, presence: true


  ##
  ## Callbacks
  ##

  before_validation :generate_api_key, on: :create
  before_validation :set_next_billing_date, on: :create
  after_create :notify_redis_of_new_api_key
  before_validation :generate_stripe_customer_token
  after_save :create_subscription_from_plan_id


  private
  
  def create_subscription_from_plan_id
    unless self.subscription.present?
      self.subscription = Subscription.create(plan_id: self.plan_id)
    end
  end
  
  def generate_api_key
    tf_digest        = OpenSSL::Digest::Digest.new('sha256')
    tf_salt_base     = OpenSSL::Random.random_bytes(4096)
    tf_salt          = Base64.encode64(tf_salt_base)
    self.api_key     = OpenSSL::HMAC.hexdigest(tf_digest, tf_salt, self.email)
  end
  
  def notify_redis_of_new_api_key
    $CUSTOMER_REDIS.set(self.api_key, '0')
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
    errors.add :base, "There was a problem processing your credit card."
    false
  end

end
