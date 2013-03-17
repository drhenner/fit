# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :subscription do
    subscription_plan { |c| c.association(:subscription_plan) }
    user       { |c| c.association(:user) }
    order_item { |c| c.association(:order_item) }
    stripe_customer_token "MyString"
    total_payments nil
  end
end
