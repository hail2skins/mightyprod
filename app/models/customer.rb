# == Schema Information
#
# Table name: customers
#
#  id          :integer          not null, primary key
#  first_name  :string(255)
#  middle_name :string(255)
#  last_name   :string(255)
#  referred_by :string(255)
#  business_id :integer
#  email       :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  deleted_at  :datetime
#

class Customer < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :business

  has_many :visits
  accepts_nested_attributes_for :visits
  
  has_many :appointments, through: :visits

  has_many :phones, as: :phoneable, dependent: :destroy
  accepts_nested_attributes_for :phones, allow_destroy: true
  
  has_many :deals
  
  has_many :gift_certificates
  has_many :comps
  
  validates_presence_of :first_name, :last_name
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, format: { with: VALID_EMAIL_REGEX }, allow_blank: true


  def name
  	"#{first_name} #{last_name}".to_s
  end
  
  def active_deals
    self.deals.where(active: true)
  end

  def completed_deals
    self.deals.where(active: false)
  end
  
  def with_visits
    self.visits.count > 0
  end
  
  def self.to_csv
    attributes = %w{ email name }
    CSV.generate(headers: true) do |csv|
      csv << attributes
      
      all.each do |customer|
        csv << attributes.map{ |attr| customer.send(attr) }
      end
    end
  end
  
# Caveat: with Arel >= 6 the separator ' ' string in the
# preceding example needs to be quoted as follows:
  ransacker :name do |parent|
    Arel::Nodes::InfixOperation.new('||',
      Arel::Nodes::InfixOperation.new('||',
        parent.table[:first_name], Arel::Nodes.build_quoted(' ')
      ),
      parent.table[:last_name]
    )
  end
end
