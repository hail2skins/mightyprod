require "spec_helper"
require "cancan/matchers"

describe "Ability" do
  describe "guests" do
    subject(:ability){ Ability.new(owner) }
    let(:owner){ nil }

    context "when visitor is guest" do
      it { should be_able_to(:read, :static_pages) }
      it { should_not be_able_to(:manage, :static_pages) }
      it { should_not be_able_to(:manage, Owner.new) }
    end
  end

  describe "owners" do
  	subject { Ability.new(owner) }

  	let(:owner) { FactoryGirl.create(:owner) }
  	let(:owner1) { FactoryGirl.create(:owner) }
 
  	let(:business) { FactoryGirl.create(:business, owner: owner) }
  	let(:business1) { FactoryGirl.create(:business, owner: owner1) }

  	it { should be_able_to :show, owner }
  	it { should_not be_able_to :show, owner1 }

  	it { should be_able_to :manage, business }
  	it { should_not be_able_to :read, business1 }
  	it { should_not be_able_to :create, business1 }
  	it { should_not be_able_to :update, business1 }
  	it { should_not be_able_to :delete, business1 }
  end

end