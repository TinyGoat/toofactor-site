require 'spec_helper'

describe Plan do
  
  subject { Fabricate(:plan) }
  
  ##
  ## Validations
  ##
  
  it "validates presence of name" do
    should validate_presence_of :name
  end
  it "validates uniqueness of name" do
    should validate_uniqueness_of :name
  end
  it "validates presence of monthly cost" do
    should validate_presence_of :monthly_cost
  end
  it "validates presence of number of bundled SMS" do
    should validate_presence_of :number_of_bundled_sms
  end
  it "validates presence of overage SMS cost" do
    should validate_presence_of :overage_sms_cost
  end
  
  
  ##
  ## Relationships
  ##
  
  it "has many subscriptions" do
    should have_many :subscriptions
  end
  it "has many users" do
    should have_many :users
  end
  
end