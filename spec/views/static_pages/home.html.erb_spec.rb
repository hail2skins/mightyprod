require 'spec_helper'

describe "static_pages/home.html.erb" do
	it "expects the controller path" do
		expect(controller.request.path_parameters[:controller]).to eq("static_pages")
		expect(controller.controller_path).to eq("static_pages")
	end
end

describe "seeing the home page" do

	it "should see links to help, contact, about and sign in" do
		visit root_path
		expect(page).to have_link('About', href: about_path)
		expect(page).to have_link('Help', href: help_path)
		expect(page).to have_link('Contact', href: contact_path)
		expect(page).to have_link('Login', href: login_path)
		expect(page).to have_link('Sign up now!', href: signup_path)
	end
end

describe "visiting each link from the home page" do
	before { visit root_path }

	it "static_pages/help.html.erb" do
		visit help_path
		expect(page).to have_title("Help")
	end

	it "static_pages/about.html.erb" do
		visit about_path
		expect(page).to have_title("About")
	end

	it "static_pages/contact.html.erb" do
		visit contact_path
		expect(page).to have_title("Contact")
	end

	it "devise/registrations/new.html.erb" do
		visit signup_path
		expect(page).to have_css('form', text: "")
		expect(page).to have_title("Sign up")
	end

	it "devise/sessions/new.html.erb" do
		visit login_path
		expect(page).to have_title("Login")
		expect(page).to have_link("Sign up")
		expect(page).to have_link("Forgot your password?")
	end
	
end
