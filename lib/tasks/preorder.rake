namespace :preorder do
  task :receive_payment_for_available_items => :environment do
    # Get the orders that are preordered
    OrderItem.preorders.find_each do |item|
      item
    end
    Order.preorders.find_each do |order|
      Order.uncached do
        if order.all_in_stock?
          order.pay!
          order.update_inventory
        end
      end
      # now we need to send the 3PL the info.  response should eventually have the shipping info.
    end
  end
end
