class Campaign < ActiveRecord::Base
  belongs_to :business
  has_many :campaign_visits
  has_many :visits, through: :campaign_visits


  validates_presence_of :name, :start_date, :expiration_date, :percentage  
  
  def self.active(time)
    where("expiration_date >= ?", time)
  end
  
  def self.completed(time)
    where("expiration_date < ?", time)
  end
  
    
  
end
