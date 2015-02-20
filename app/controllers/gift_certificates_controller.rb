class GiftCertificatesController < ApplicationController
  before_action :get_customer_business_and_owner, except: [ :redeem, :update ]
  before_action :set_gift_certificate, only: [ :show, :edit]
  before_action :set_redeem_gift_certificate, only: [ :redeem ]

  def new
    @gift_certificate = @customer.gift_certificates.build
    @gift_certificate.prices.build(params[:price])
    @gift_certificate.comments.build(params[:comment])
  end
  
  def create
    @gift_certificate = @customer.gift_certificates.new(gift_certificate_params)
    respond_to do |format|
      if @gift_certificate.save
        update_certificate_info
        
        
        format.html { redirect_to [@customer, @gift_certificate], notice: "Gift Certificate created." }
      else
        format.html { render action: 'new' }
      end
    end
  end 

  def show
  end
  
  def index
    @gift_certificates = @customer.gift_certificates.all
  end
  
  def edit
  end
  
  def update

    if params[:commit] == "Redeem Gift Certificate"
      set_redeem_gift_certificate 
      if params[:gift_certificate][:active] == "1"
 
      respond_to do |format|
        if @gift_certificate.update(gift_certificate_params)
          redeem_update_params
          format.html { redirect_to gift_certificates_business_path(@business), notice: "Gift Certificate Redeemed." }
        else
          format.html { render action: 'redeem' }
        end
      end
      
      else
        respond_to do |format|
          format.html {redirect_to gift_certificates_business_path(@business), notice: "You did not check the box, so the certificate is not redeemed." }
        end
      end
  
    else 
      respond_to do |format|
        get_customer_business_and_owner
        set_gift_certificate
        if @gift_certificate.update(gift_certificate_params)
        
         format.html { redirect_to [@owner, @business], notice: "Gift Certificate successfully edited." }
        else
         format.html { render action: 'new' }
        end
      end      
    end
  end
  
  
  def redeem

   #@gift_certificate.update(gift_certificate_params)
  
  end
  
  
  private
 
      def set_gift_certificate
        @gift_certificate = @customer.gift_certificates.find(params[:id])
      end
      
      def set_redeem_gift_certificate
        @business = Business.find(params[:business_id])
        @gift_certificate = @business.gift_certificates.find(params[:id])
        @owner = @business.owner
        @customer = @gift_certificate.customer
      end
      
      
      def get_customer_business_and_owner
        @customer = Customer.find(params[:customer_id]) 
        @business = @customer.business
        @owner = @business.owner
      end
      
      def gift_certificate_params
        params.require(:gift_certificate).permit(:active, :redemption_comment, :customer_id, :initial_comment, :prices_attributes => [:id, :amount])
      end
      
      def update_certificate_info
        @gift_certificate.update_attribute(:business_id, @business.id)
        certificate_number = @business.gift_certificates.count
        @gift_certificate.update_attribute(:certificate_number, certificate_number)
      end
      
      def redeem_update_params
          @gift_certificate.update_attribute(:active, false)
          @gift_certificate.update_attribute(:date_redeemed, Time.now)
      end

end