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
  validates :user, presence: true
  validates :plan, presence: true


  ##
  ## Callbacks
  ##
  
  before_validation :set_subscribed_at, on: :create
  before_destroy :set_canceled_at
  
  
  ##
  ## Scopes
  ##
  
  scope :active, where(canceled_at: nil)
  scope :inactive, where('subscriptions.canceled_at IS NOT NULL')
  
  
  ##
  ## Instance Methods
  ##
  
  def active?
    self.canceled_at.nil?
  end
  
  def terminate!
    if self.canceled_at.blank?
      self.canceled_at = Time.now
      self.save!
    end
  end
  
  
  private
  
  def set_subscribed_at
    self.subscribed_at = Time.now
  end
  
  def set_canceled_at
    self.canceled_at = Time.now
  end

end
