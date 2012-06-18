class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

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
  validates :dev_api_key, presence: true, uniqueness: true
  validates :plan_id, presence: true


  ##
  ## Callbacks
  ##

  before_validation :generate_api_keys, on: :create
  before_validation :set_next_billing_date, on: :create
  after_create :notify_redis_of_new_api_keys
  before_validation :generate_stripe_customer_token
  after_save :create_subscription_from_plan_id


  private
  
  def create_subscription_from_plan_id
    self.subscription = Subscription.create(plan_id: self.plan_id)
  end
  
  def generate_api_keys
    tf_digest        = OpenSSL::Digest::Digest.new('sha256')
    tf_salt_base     = OpenSSL::Random.random_bytes(4096)
    tf_salt          = Base64.encode64(tf_salt_base)
    self.api_key     = OpenSSL::HMAC.hexdigest(tf_digest, tf_salt, self.email)
    self.dev_api_key = OpenSSL::HMAC.hexdigest(tf_digest, tf_salt, 'dev+'+self.email)
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
