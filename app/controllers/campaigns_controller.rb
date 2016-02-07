class CampaignsController < ApplicationController
  before_action :get_business_and_owner
  before_action :set_campaign, only: [ :show, :edit ]
  
  def new
    @campaign = @business.campaigns.build
  end
  
  def create
    @campaign = @business.campaigns.new(campaign_params)
    respond_to do |format|
      if @campaign.save
        format.html { redirect_to [@owner, @business], notice: "Campaign Created." }
      else
        format.html { render action: 'new' }
      end
    end
  end
  
  def active
    @active = @business.campaigns.active(Time.now)
  end
  
  
  
  private
    def set_campaign
      @campaign = @business.campaigns.find(params[:id])
    end
    
    def get_business_and_owner
      @business = Business.find(params[:business_id])
      @owner = @business.owner
    end

    def campaign_params
      params.require(:campaign).permit(:name, :description, :business_id, :percentage, :start_date, :expiration_date)
    end
  

end