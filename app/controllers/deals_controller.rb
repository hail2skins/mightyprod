class DealsController < ApplicationController
  before_action :get_customer_business_and_owner
  before_action :set_deal, only: [:show, :edit, :update, :destroy]

  def index
    @deals = @customer.deals.all
  end
  
  def new
    @deal = @customer.deals.build
  end

  def create
    @deal = @customer.deals.new(deal_params)
 
    respond_to do |format|
      if @deal.save
        set_package_and_update
        format.html { redirect_to [@business, @customer], notice: "Package purchased for " + @customer.name }
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
      if @deal.update(deal_params)
        deal_completed
        format.html { redirect_to [@business, @customer], notice: "Deal Updated"}
      else
        format.html { render action: 'edit' }
      end
    end
  end  
  
  def destroy
    @deal.destroy
    respond_to do |format|
      format.html { redirect_to [@business, @customer], notice: 'Customer deal has been deleted.' }
    end
  end
    
    

  
  private
      def deal_params
        params.require(:deal).permit(:date_purchased, :date_completed, :used_count, :customer_id, :package_id)
      end
      
      def set_deal
        @deal = @customer.deals.find(params[:id])
      end
      
      def get_customer_business_and_owner
        @customer = Customer.find(params[:customer_id])
        @business = @customer.business
        @owner = @business.owner
      end
      
      def set_package_and_update
        @package = @deal.package
        @deal.update_attribute(:used_count, @package.count)
        @deal.update_attribute(:business_id, @business.id)
        set_active_state
      end
      
      def set_active_state
        @deal.update_attribute(:active, true) unless @deal.used_count == 0
      end
      
      def deal_completed
        if @deal.used_count < 1 && @deal.active == true
          @deal.update_attribute(:active, false)
          @deal.update_attribute(:date_completed, Date.today)
        elsif @deal.used_count > 0 && @deal.active == false
          @deal.update_attribute(:active, true)
          @deal.update_attribute(:date_completed, nil)
        end
      end
      
      
end
