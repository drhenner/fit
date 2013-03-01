class Subscription < ActiveRecord::Base
  attr_accessible :order_item_id, :stripe_customer_token, :subscription_plan_id, :total_payments, :user_id, :active#, :product_id

  belongs_to :user
  belongs_to :order_item
  belongs_to :subscription_plan

  validates :order_item_id,         :presence => true
  validates :stripe_customer_token, :presence => true, :if => :active?
  validates :subscription_plan_id,  :presence => true
  validates :user_id,               :presence => true

end
