class Subscription < ActiveRecord::Base
  attr_accessible :order_item_id, :stripe_customer_token, :subscription_plan_id, :total_payments, :user_id, :active, :remaining_payments
  #, :product_id

  belongs_to :user
  belongs_to :order_item
  belongs_to :subscription_plan

  validates :order_item_id,         :presence => true
  validates :stripe_customer_token, :presence => true, :if => :active?
  validates :next_bill_date,        :presence => true, :if => :active?
  validates :subscription_plan_id,  :presence => true
  validates :user_id,               :presence => true

  def purchased!
    self.active = true
    self.next_bill_date ||= (Time.zone.now + 1.month).to_date
    # log in account system as ...
    self.save!
  end

  def completed_billing_cycle!
    self.remaining_payments = remaining_payments - 1
    self.next_bill_date = next_bill_date + 1.month unless self.remaining_payments <= 0
    self.save!
  end

  def self.active
    where(:subscriptions => {:active => true})
  end

  def self.not_canceled
    where(:subscriptions => {:canceled => false})
  end

  def self.has_remaining_payments
    where("subscriptions.remaining_payments > 0")
  end

  def self.needs_to_be_billed
    active.not_canceled.has_remaining_payments.where('next_bill_date >= ?', Time.zone.now.to_date)
  end
end
