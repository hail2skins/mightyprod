# == Schema Information
#
# Table name: visits
#
#  id            :integer          not null, primary key
#  visit_notes   :text
#  date_of_visit :date
#  customer_id   :integer
#  created_at    :datetime
#  updated_at    :datetime
#  business_id   :integer
#  deal_id       :integer
#  deal_visit    :boolean          default("false")
#

class Visit < ActiveRecord::Base
  belongs_to :customer
  belongs_to :deal
  accepts_nested_attributes_for :deal
  
  validates_presence_of :customer_id
  validates_presence_of :date_of_visit
  #validates :date_of_visit, date: true   NOT NEEDED as field itself validates well.  I think.
  validates_uniqueness_of :date_of_visit, scope: :customer_id, on: [ :create ]
  
  has_many :appointments, dependent: :destroy
  has_many :services, through: :appointments
  validates :services, presence: true, unless: :deal_visit?
  
  has_one :comp, dependent: :destroy
  accepts_nested_attributes_for :comp
  
  has_many :campaign_visits, dependent: :destroy
  has_many :campaigns, through: :campaign_visits

end

def deal_visit?
  self.deal_visit = true
end

def active_deal
  @customer.deals.where(active: true)
end

def visit_amount
  if @visit.comp(:amount_comp)
    @visit.appointments.sum(:amount) - @visit.comp.amount_comp
  else
    @visit.appointments.sum(:amount)
  end
end
