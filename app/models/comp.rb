class Comp < ActiveRecord::Base
  belongs_to :business
  belongs_to :visit
  belongs_to :customer
  
end
