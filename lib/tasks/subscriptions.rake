namespace :subscription do
  task :receive_payment_for_subscriptions => :environment do
    # Get the orders that are preordered
    Subscription.needs_to_be_billed.find_each do |subscription|
      stripe_charge = Payment.stripe_customer_capture(subscription.individual_cost, subscription.stripe_customer_token, "Subscription: #{subscription.subscription_plan_name}", {})
      if stripe_charge.paid
        subscription.completed_billing_cycle!
        batch = subscription.batches.first || subscription.batches.create
        batch.transactions.push(SubscriptionTransaction.new_capture_payment(subscription, subscription.individual_cost, subscription.individual_tax_amount))
        batch.save
      else
        # subscription.log_failure!
      end
    end
  end
end
