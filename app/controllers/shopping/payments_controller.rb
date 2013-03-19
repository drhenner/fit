class Shopping::PaymentsController < Shopping::BaseController


  private

  def selected_checkout_tab(tab)
    tab == 'payment-info'
  end
end
