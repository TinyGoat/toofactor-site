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
                  :stripe_token,
                  :api_key,
                  :next_billing_date


  ##
  ## Validations
  ##

  validates :email, presence: true, uniqueness: true
  validates :next_billing_date, presence: true
  validates :api_key, presence: true, uniqueness: true

  ##
  ## Callbacks
  ##

  before_validation :generate_api_key, on: :create
  before_validation :set_next_billing_date, on: :create


  private
  def generate_api_key
    self.api_key = (Digest::RMD160.new << self.email + API_KEY_SALT).to_s
  end

  def set_next_billing_date
    self.next_billing_date = 15.days.from_now
  end

end
