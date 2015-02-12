require 'spec_helper'

describe "Owner pages" do
	subject { page }

  describe "devise/registrations/new.html.erb" do
  	before do 
  		visit signup_path
	  	expect(page).to have_content('Sign up')
  		expect(page).to have_title('Sign up')
  	end
  end
end

describe "signup" do
	before { visit '/signup' }

	let(:submit) { "Create my account" }


  describe "with valid information" do
	  before do
			fill_in "First name", 						with: "Example"
			fill_in "Middle name", 						with: ""
			fill_in "Last name", 							with: "User"
			fill_in "Email", 									with: "user@example.com"
			fill_in "Password",								with: "password", match: :prefer_exact
			fill_in "Confirm Password", 			with: "password", match: :prefer_exact
		end

		it "should create an owner" do
			expect { click_button submit }.to change(Owner, :count).by(1)
		end
	end

	describe "with invalid information" do
		
		it "should not create an owner" do
			expect { click_button submit }.not_to change(Owner, :count)
		end

		it "should have certain page attributes" do
			click_button submit
			expect(page).to have_content("Sign up")
			expect(page).to have_content("Please review the problems below:")
			expect(page).to have_content("can't be blank")
		end
	end

end