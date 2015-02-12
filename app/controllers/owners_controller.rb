class OwnersController < ApplicationController
  before_action :set_owner, only: [:show, :edit, :update, :destroy]
  before_action :set_business
  load_and_authorize_resource

	
	def show
	end

	

	private
    def owner_params
      params.require(:owner).permit(:first_name, :last_name, :middle_name, :email, :password, :password_confirmation)
    end

		def set_owner
			@owner = Owner.find(params[:id])
		end	

		def set_business
			@business = @owner.selected_business
		end

end