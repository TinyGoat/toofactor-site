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
  
end