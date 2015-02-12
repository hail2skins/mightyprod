# == Schema Information
#
# Table name: owners
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  first_name             :string(255)
#  last_name              :string(255)
#  middle_name            :string(255)
#  admin                  :boolean          default(FALSE)
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#  failed_attempts        :integer          default(0), not null
#  unlock_token           :string(255)
#  locked_at              :datetime
#  created_at             :datetime
#  updated_at             :datetime
#  deleted_at             :datetime
#


require 'spec_helper'

describe Owner do

  before(:each) do
    @attr = {
      first_name: "Example",
      last_name: "User",
      email: "user@example.com",
      password: "changeme",
      password_confirmation: "changeme"
    }
  end

  it "should create a new instance given a valid attribute" do
    Owner.create!(@attr)
  end

  it "should require an email address" do
    no_email_owner = Owner.new(@attr.merge(email: ""))
    expect(no_email_owner).to_not be_valid
  end

  it "should accept valid email addresses" do
    addresses = %w[owner@foo.com THE_OWNER@foo.bar.org first.last@foo.jp]
    addresses.each do |address|
      valid_email_owner = Owner.new(@attr.merge(email: address))
      expect(valid_email_owner).to be_valid
    end
  end

  it "should reject invalid email addresses" do
    addresses = %w[owner@foo,com owner_at_foo.org example.owner@foo.]
    addresses.each do |address|
      invalid_email_owner = Owner.new(@attr.merge(email: address))
      expect(invalid_email_owner).to_not be_valid
    end
  end

  it "should reject duplicate email addresses" do
    Owner.create!(@attr)
    owner_with_duplicate_email = Owner.new(@attr)
    expect(owner_with_duplicate_email).to_not be_valid
  end

  it "should reject email addresses identical up to case" do
    upcased_email = @attr[:email].upcase
    Owner.create!(@attr.merge(email: upcased_email))
    owner_with_duplicate_email = Owner.new(@attr)
    expect(owner_with_duplicate_email).to_not be_valid
  end

  describe "passwords" do

    before(:each) do
      @owner = Owner.new(@attr)
    end

    it "should have a password attribute" do
      expect(@owner).to respond_to(:password)
    end

    it "should have a password confirmation attribute" do
      expect(@owner).to respond_to(:password_confirmation)
    end
  end

  describe "password validations" do

    it "should require a password" do
      expect(Owner.new(@attr.merge(password: "", password_confirmation: ""))).to_not be_valid
    end

    it "should require a matching password confirmation" do
      expect(Owner.new(@attr.merge(password_confirmation: "invalid"))).to_not be_valid
    end

    it "should reject short passwords" do
      short = "a" * 5
      hash = @attr.merge(password: short, password_confirmation: short)
      expect(Owner.new(hash)).to_not be_valid
    end

  end

  describe "password encryption" do

    before(:each) do
      @owner = Owner.create!(@attr)
    end

    it "should have an encrypted password attribute" do
      expect(@owner).to respond_to(:encrypted_password)
    end

    it "should set the encrypted password attribute" do
      expect(@owner.encrypted_password).to_not be_blank
    end

  end

  describe "first_name, last_name, middle_name and name" do
  	before(:each) do
      @owner = Owner.new(@attr)
    end



  	it "should have a #first_name" do
  		expect(@owner).to respond_to(:first_name)
  	end

 		it "should require first_name" do
    	no_firstname_owner = Owner.new(@attr.merge(first_name: ""))
    	expect(no_firstname_owner).to_not be_valid
    end

    it "should have a last_name" do
    	expect(@owner).to respond_to(:last_name)
    end

 		it "should require last_name" do
    	no_lastname_owner = Owner.new(@attr.merge(last_name: ""))
    	expect(no_lastname_owner).to_not be_valid
    end

    it "should have a middle_name" do
    	expect(@owner).to respond_to(:middle_name)
    end

    it "#name should combine first_name and last_name" do
    	expect(@owner.name).to eq("Example User")
    end

  end

  describe "admin" do
  	before(:each) do
      @owner = Owner.new(@attr)
    end

    it "admin should be false" do
    	expect(@owner.admin?).to be(false)
    end

  end

end
