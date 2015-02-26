class CompsController < ApplicationController
  before_action :get_customer_business_and_owner
  #before_action :set_comp, only: [ :show, :edit]
  
  def index
   @comps = @customer.comps.all
  end
  
  private
 
      def get_customer_business_and_owner
        @customer = Customer.find(params[:customer_id]) 
        @business = @customer.business
        @owner = @business.owner
      end
      
end