require 'spec_helper'

describe User do
  
  before(:each) do
    @user = Fabricate(:user)
  end
  
  ##
  ## Relationships
  ##
  
  it "has one subscription" do
    @user.should have_one :subscription
  end
  it "has one plan" do
    @user.should have_one :plan
  end
  
  
  ##
  ## Validations
  ##
  
  context "validations" do
    it "validate presence of email" do
      @user.should validate_presence_of :email
    end
    it "validate uniqueness of email" do
      @user.should validate_uniqueness_of :email
    end
  
    it "validate presence of next_billing_date" do
      @user.should validate_presence_of :next_billing_date
    end
  
    it "validate presence of api_key" do
      @user.should validate_presence_of :api_key
    end
    it "validate uniquness of api_key" do
      # can't use default shoulda-matcher uniqueness test here because we're
      # generating an API key on create.
      user = Fabricate(:user)
      user2 = Fabricate(:user)
      user.api_key = user2.api_key
      expect do
        user.save!
      end.to raise_error ActiveRecord::RecordInvalid
      user.errors[:api_key].should include "has already been taken"
    end
  end
  
  
  ##
  ## Callbacks
  ##
  
  context "callbacks" do
    it "generate an API key when created" do
      user = Fabricate.build(:user, api_key: nil)
      expect do
        user.save!
      end.to_not raise_error
      user.reload.api_key.should_not be_nil
    end
  end
  
end