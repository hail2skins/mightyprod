class PackagesController < ApplicationController
  
  before_action :get_business_and_owner
  before_action :set_package, only: [ :show, :edit, :update, :destroy ]
  before_action :set_service, only: [ :show, :edit, :update, :destroy ]


  def index
    @packages = @business.packages.all
  end
  
  def new
    @package = @business.packages.build
    @package.prices.build(params[:price])
  end
  
  def create
    @package = @business.packages.new(package_params)
    
    respond_to do |format|
      if @package.save
        format.html { redirect_to [@owner, @business], notice: "Package added." }
      else
        format.html { render action: 'new' }
      end
    end
  end
  
  def show
  end
  
  def edit
  end

  def update
    respond_to do |format|
      if @package.update(package_params)
        format.html { redirect_to [@owner, @business], notice: "Package updated." }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def destroy
    @package.destroy
    respond_to do |format|
      format.html { redirect_to [@owner, @business], notice: 'Package deleted.' }
    end  
  end
  

  private
      def get_business_and_owner
        @business = Business.find(params[:business_id])
        @owner = @business.owner
      end
      
      def set_package
        @package = @business.packages.find(params[:id])
      end
      
      def package_params
        params.require(:package).permit(:name, :description, :count, :date_purchased, :service_id, prices_attributes: [:id, :amount])
      end
      
      def set_service
        @service = Service.find_by_id(@package.service_id)
      end
end