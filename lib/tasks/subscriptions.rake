# rake subscription:receive_payment_for_subscriptions
namespace :subscription do
  task :receive_payment_for_subscriptions => :environment do
    # Get the orders that are preordered
    if nil
      Subscription.needs_to_be_billed.find_each do |subscription|
        stripe_charge = Payment.stripe_customer_capture(subscription.individual_cost, subscription.stripe_customer_token, "Subscription: #{subscription.subscription_plan_name}", {})

        puts "------------------------#{subscription.id}-----------------------------"
        puts stripe_charge.inspect
        if stripe_charge.paid
          puts 'stripe_charge.paid true'
          subscription.completed_billing_cycle!
          batch = subscription.batches.first || subscription.batches.create
          batch.transactions.push(SubscriptionTransaction.new_capture_payment(subscription, subscription.individual_cost, subscription.individual_tax_amount))
          batch.save
          puts "batch.valid?  #{batch.valid?}"
        else
          # subscription.log_failure!
        end
        puts "+++++===================#{subscription.id}===============================------"
      end
    else
      puts "DONT RUN THIS TASK...  subscription now create ORDERS"
    end
  end
  task :receive_payment_for_subscriptions => :environment do
    # Get the orders that are preordered
    Subscription.needs_to_be_billed.find_each do |subscription|
      order = Order.new(
                  :bill_address_id => subscription.billing_address_id,
                  :ship_address_id => subscription.shipping_address_id,
                  :user_id         => subscription.user_id,
                  :payment_profile_id => subscription.payment_profile_id
                )
      if subscription.cheapest_shipping_rate
        order.add_subscribed_item(subscription.variant, subscription.cheapest_shipping_rate.id, subscription.shipping_address.state_id)
        order.reload

        invoice = order.create_invoice(nil, order.find_total, subscription.payment_profile)
        if invoice.succeeded?
          subscription.completed_billing_cycle!
        end
      else
        puts 'CRAP WE FAILED'
      end
      puts "+++++===================#{subscription.id}===============================------"
    end
  end
end
