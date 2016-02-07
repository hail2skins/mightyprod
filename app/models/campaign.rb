class Campaign < ActiveRecord::Base
  belongs_to :business
  
  
  def self.active(time)
    where("expiration_date >= ?", time)
  end
  
  def self.completed(time)
    where("expiration_date < ?", time)
  end
  
    
  
end
