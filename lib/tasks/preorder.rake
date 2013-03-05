namespace :preorder do
  task :receive_payment_for_available_items => :environment do
    # Get the orders that are preordered
    OrderItem.preorders.find_each do |item|
      item
    end
    Order.preorders.find_each do |order|
      Order.uncached do
        order.pay! if order.all_in_stock?
      end
    end
  end
end
