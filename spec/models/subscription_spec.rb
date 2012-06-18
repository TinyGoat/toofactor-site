require 'spec_helper'

describe Subscription do
  
  subject { Fabricate(:subscription) }
  
  ##
  ## Relationships
  ##
  
  it "belongs to a user" do
    should belong_to :user
  end
  it "belongs to a plan" do
    should belong_to :plan
  end
  
  
  ##
  ## Validations
  ##
  
  it "validates presence of subscribed at time" do
    should validate_presence_of :subscribed_at
  end
  
  
  ##
  ## Scopes
  ##
  
  context "Subscription.active" do
    
    it "returns active subscriptions" do
      active_subscriptions = Array.new(3) { Fabricate(:active_subscription) }
      canceled_subscriptions = Array.new(2) { Fabricate(:canceled_subscription) }
      (active_subscriptions - Subscription.active).should be_empty
      (canceled_subscriptions - Subscription.active).should == canceled_subscriptions
    end
    
  end
  
  context "Subscription.inactive" do
    
    it "returns canceled subscriptions" do
      active_subscriptions = Array.new(3) { Fabricate(:active_subscription) }
      canceled_subscriptions = Array.new(2) { Fabricate(:canceled_subscription) }
      (canceled_subscriptions - Subscription.inactive).should be_empty
      (active_subscriptions - Subscription.inactive).should == active_subscriptions
    end
    
  end
  
  
  ##
  ## Instance Methods
  ##
  
  context '#active?' do
    
    it 'returns true for active subscriptions' do
      subscription = Fabricate(:active_subscription)
      subscription.should be_active
    end
    
    it 'returns false for canceled subscriptions' do
      subscription = Fabricate(:canceled_subscription)
      subscription.should_not be_active
    end
    
  end
  
  
  context '#terminate!' do
    
    context 'on active subscriptions' do
      
      before(:each) do
        @subscription = Fabricate(:active_subscription)
      end
      
      it 'sets the canceled_at time to the current time' do
        @subscription.canceled_at.should be_nil
        @subscription.terminate!
        @subscription.canceled_at.should_not be_nil
        @subscription.canceled_at.should be_within(2).of(Time.now)
      end
      
    end
    
    context 'on canceled subscriptions' do
      
      before(:each) do
        @subscription = Fabricate(:canceled_subscription)
      end
      
      it 'does not update canceled_at' do
        @subscription.canceled_at.should_not be_nil
        previous_time = @subscription.canceled_at
        @subscription.terminate!
        @subscription.reload.canceled_at.should == previous_time
      end
      
    end
    
  end
  
end