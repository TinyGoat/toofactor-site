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
                  :api_key

  ##
  ## Callbacks
  ##

  before_create :generate_api_key


  private
  def generate_api_key
    self.api_key = (Digest::RMD160.new << self.email + API_KEY_SALT).to_s
  end

end
