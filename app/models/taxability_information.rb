class TaxabilityInformation < ActiveRecord::Base
  attr_accessible :code, :name
  has_many :variants

  validates :name,  :presence => true
  validates :code,  :presence => true
end
