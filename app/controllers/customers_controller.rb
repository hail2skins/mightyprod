class CustomersController < ApplicationController
	before_action :get_business_and_owner
	before_action :set_customer, only: [:show, :edit, :update, :destroy]

	def index
		@q = @business.customers.search(params[:q])
		@q.sorts = 'first_name asc' if @q.sorts.empty?
		if request.format == "csv"
			@customers = @q.result(distinct: true)
		else
			@customers = @q.result(distinct: true).paginate(page: params[:page]).includes(:phones)
    end
    @visiting_customers = @business.customers.joins(:visits).group("customers.id").having("count(visits.id) > 0").includes(:phones) 
	
		respond_to do |format|
			format.html
			format.csv { send_data @customers.to_csv, filename: "customers-#{Date.today}.csv" }
		end
	
	end
	
	

	def show
    @visit = @customer.visits.last
	end

	def new
		@customer = @business.customers.build
    @customer.phones.build(params[:phones])
	end

	def create
		@customer = @business.customers.new(customer_params)

		respond_to do |format|
			if @customer.save
				format.html { redirect_to owner_business_path(@owner, @business), notice: "Customer added." }
			else
				format.html { render action: 'new' }
			end
		end
	end

	def edit
  end

  def update
    respond_to do |format|
      if @customer.update(customer_params)
        format.html { redirect_to [@owner, @business], notice: "Information for #{@customer.name} has been updated."}
      else
        format.html { render action: 'edit' }
      end
    end
  end

  def destroy
  	session[:return_to] ||= request.referer
    @customer.destroy
    respond_to do |format|
      if URI(request.referer).path == business_customers_path(@business) 
      	format.html { redirect_to business_customers_path(@business), 
      								notice: 'Customer has been deleted.' }
    	else
    		format.html { redirect_to [@owner, @business],
    									notice: 'Customer has been deleted.'}
    	end
    end
  end
  
  def search
  	@q = @business.customers.search(params[:q])
  	@customers = @q.result(distinct: true).paginate(page: params[:page]).includes(:phones)
  end

	private

			def set_customer
				@customer = @business.customers.find(params[:id])
			end

			def get_business_and_owner
				@business = Business.find(params[:business_id])
				@owner = @business.owner
			end

			def customer_params
				params.require(:customer).permit(:first_name, :middle_name, :last_name, :email, :referred_by, phones_attributes: [:id, :number])
			end


end
