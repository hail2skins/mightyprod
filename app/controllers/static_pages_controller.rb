class StaticPagesController < ApplicationController
	def home
  	#Allows the current_user to create a business and bind to user_id if signed_in, which is provided by Devise.
 		if signed_in?
      redirect_to current_owner
    else
      render 'static_pages/home'
  	end
  end
	

	def about
	end

	def help
	end

	def contact
	end
	
end