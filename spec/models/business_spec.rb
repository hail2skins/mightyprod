# == Schema Information
#
# Table name: businesses
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  deleted_at  :datetime
#  created_at  :datetime
#  updated_at  :datetime
#  owner_id    :integer
#  selected    :boolean          default(FALSE)
#


require 'spec_helper'

describe Business do
	let(:owner) { FactoryGirl.create(:owner) }
	let(:business) {FactoryGirl.create(:business, owner: owner) }
  
  it "retains business and updates deleted_at column when destroy called" do
  	expect(business.deleted_at).to be(nil)
    business.destroy
    expect(business.deleted_at).to_not be(nil)
  end

  it "restore sets deleted_at to nil" do
  	business.destroy
  	expect(business.deleted_at).to_not be(nil)
  	business.restore
  	expect(business.deleted_at).to be(nil)
  end

  it "deletes business for real using really_destroy!" do
  	expect(business.deleted_at).to be(nil)
  	expect { business.really_destroy! }.to change(Business, :count).from(1).to(0)
  end


	it "should have a #name" do
 		expect(business).to respond_to(:name)
 	end

 	it "should have a #description" do
 		expect(business).to respond_to(:description)
 	end

 	it "should require #name" do
   	no_name_business = FactoryGirl.build(:business, owner: owner, name: "")
   	expect(no_name_business).to_not be_valid
  end

  
end
