# == Schema Information
#
# Table name: payment_profiles
#
#  id             :integer(4)      not null, primary key
#  user_id        :integer(4)
#  address_id     :integer(4)
#  payment_cim_id :string(255)
#  default        :boolean(1)
#  active         :boolean(1)
#  created_at     :datetime
#  updated_at     :datetime
#  last_digits    :string(255)
#  month          :string(255)
#  year           :string(255)
#  cc_type        :string(255)
#  first_name     :string(255)
#  last_name      :string(255)
#  card_name      :string(255)
#

##  NOTE  Payment profile methods have been created however these methods have not been tested in any fashion
#   These method are here to give you a heads start.  Once CIM is created these methods will be ready for use.
#
# => Please refer to the following web page about seting up CIM.  This code has not been fully tested but
#     should serve you very well.
# http://cookingandcoding.com/2010/01/14/using-activemerchant-with-authorize-net-and-authorize-cim/
#
class PaymentProfile < ActiveRecord::Base
  belongs_to :user
  belongs_to :address

  before_save :set_default_if_first_card

  attr_accessor       :request_ip, :credit_card

  validates :user_id,         :presence => true
  validates :payment_cim_id,  :presence => true
  validates :cc_type,         :presence => true, :length => { :maximum => 60 }
  validates :last_digits,     :presence => true, :length => { :maximum => 10 }
  validates :month,           :presence => true, :length => { :maximum => 6 }
  validates :year,            :presence => true, :length => { :maximum => 6 }

  private

    def set_default_if_first_card
      if PaymentProfile.where('user_id = ?', user_id).count == 0
        self.default = true
      end
    end

end
