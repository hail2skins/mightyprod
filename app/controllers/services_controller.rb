class ServicesController < ApplicationController
  before_action :get_business_and_owner
  before_action :set_service, only: [:show, :edit, :update, :destroy]
  
  def new
    @service = @business.services.build
    @service.prices.build(params[:price])
  end
  
  def create
    @service = @business.services.new(service_params)
    
    respond_to do |format|
      if @service.save
        format.html { redirect_to [@owner, @business], notice: 'New service created.' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def index
    @services = @business.services.all
  end
  
  def show
  end
  
  def edit
  end
  
  def update
    respond_to do |format|
      if @service.update(service_params)
        format.html { redirect_to [@owner, @business], notice: "Service updated."}
      else
        format.html { render action: 'edit' }
      end
    end
  end
  
  def destroy
    @service.destroy
    respond_to do |format|
      format.html { redirect_to [@business, @customer], notice: 'Service deleted.' }
    end  
  end
      
  private
  
      def set_service
        @service = Service.find(params[:id])
      end
  
      def service_params
        params.require(:service).permit(:name, :description, :business_id, :prices_attributes => [:id, :amount])
      end
      
      def get_business_and_owner
				@business = Business.find(params[:business_id])
				@owner = @business.owner
			end
end