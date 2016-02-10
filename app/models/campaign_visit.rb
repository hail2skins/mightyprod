class CampaignVisit < ActiveRecord::Base
  belongs_to :campaign
  belongs_to :visit
end
