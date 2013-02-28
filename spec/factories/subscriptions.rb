# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :subscription do
    subscription_plan_id 1
    user_id 1
    order_id 1
    stripe_customer_token "MyString"
    total_payments ""
  end
end
