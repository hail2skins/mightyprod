class BusinessesController < ApplicationController
	before_action :get_owner
	before_action :set_business, only: [:show, :edit, :update, :destroy]
	load_and_authorize_resource :owner
	load_and_authorize_resource :business, through: :owner
	after_action :update_selected, only: :create


	def new
		@business = @owner.businesses.new
	end

	def create

		@business = @owner.businesses.build(business_params)

		respond_to do |format|
			if @business.save 
			  if @owner.businesses.count == 1
				  format.html { redirect_to owner_business_path(@owner, @business), notice: 'Congratulations.  Your business has been created.'  }
				else
				  format.html { redirect_to current_owner, notice: 'Congratulations.  Your business has been created.' }
				end
			else
				format.html { render 'new' }
			end
		end
	end

	def show
		@q = @business.customers.search(params[:q])
		@customers = @q.result(distinct: true).paginate(page: params[:page]).includes(:phones)
		@visiting_customers = @business.customers.joins(:visits).group("customers.id").having("count(visits.id) > 0").includes(:phones)
	end

	def edit
	end

	def update
  	respond_to do |format|
  		if @business.update(business_params)
  			format.html { redirect_to owner_business_path(current_owner, @business), notice: "Your business information has been successfully updated." }
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
				if @business.valid?
				  @business.update_attribute(:selected, true) unless @owner.businesses.count > 1 
				end
			end

end