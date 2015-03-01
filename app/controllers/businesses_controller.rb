class BusinessesController < ApplicationController
	before_action :get_owner
	before_action :set_business, only: [:show, :edit, :update, :destroy]
	load_and_authorize_resource :owner
	load_and_authorize_resource :business, through: :owner
	after_action :update_selected, only: :create


	def new
		@business = @owner.businesses.build
	end

	def create

		@business = @owner.businesses.new(business_params)

		respond_to do |format|
			if @business.save && @owner.businesses.count == 1 then
				format.html { redirect_to owner_business_path(@owner, @business) }
			elsif
				format.html { redirect_to current_owner, notice: 'Congratulations.  Your business has been created.' }
			else
				format.html { render action: 'new' }
			end
		end
	end

	def show
		@customers = @business.customers.includes(:phones).limit(100)
	end

	def edit
	end

	def update
  	respond_to do |format|
  		if @business.update(business_params)
  			format.html { redirect_to @owner, notice: "Your business information has been successfully updated." }
			else
				format.html { render action: 'edit' }
			end
		end
	end

	def destroy
		@business.destroy
		respond_to do |format|
			format.html { redirect_to @owner, notice: 'You have deleted this registered business.' }
		end
	end
	
	def visits
	  @visits = @business.visits.paginate(page: params[:page]).includes(:customer)
	end
	
	def gift_certificates
		@gift_certificates = @business.gift_certificates.all
	end
	
	def comps
		@comps = @business.comps.all
	end

	
	def send_bulk_email
		@business.customers.each do |customer|
			TestBulkMailer.bulk_email(customer).deliver_later unless customer.email == ""
		end
		
		redirect_to owner_business_path(@owner, @business)
	end

	private

			def get_owner
				@owner = current_owner
			end

			def set_business
				@business = @owner.businesses.find(params[:id])
			end

			def business_params
				params.require(:business).permit(:name, :description, :selected)
			end

			def update_selected
				@business.update_attribute(:selected, true) unless @owner.businesses.count > 1 
			end

end