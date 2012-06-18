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
  it "validates presence of number of bundled emails" do
    should validate_presence_of :number_of_bundled_emails
  end
  it "validates presence of overage email cost" do
    should validate_presence_of :overage_email_cost
  end
  it "validates presence of SMS cost" do
    should validate_presence_of :sms_cost
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