class Subscription < ActiveRecord::Base

  attr_accessible :plan_id,
                  :user_id

  ##
  ## Relationships
  ##

  belongs_to :user
  belongs_to :plan


  ##
  ## Validations
  ##

  validates :subscribed_at, presence: true


  ##
  ## Callbacks
  ##
  
  before_validation :set_subscribed_at, on: :create
  before_destroy :set_canceled_at
  
  private
  
  def set_subscribed_at
    self.subscribed_at = Time.now
  end
  
  def set_canceled_at
    self.canceled_at = Time.now
  end

end
