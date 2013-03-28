# == Schema Information
#
# Table name: export_types
#
#  id   :integer          not null, primary key
#  name :string(255)      not null
#

class ExportType < ActiveRecord::Base
  attr_accessible :name
  has_many :export_documents
  validates :name,        :presence => true, :uniqueness => true, :length => {:maximum => 200}

  MONTHLY_ACCOUNTING = 'Monthly Accounting'
  NAMES = [MONTHLY_ACCOUNTING]
end
