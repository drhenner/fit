class CreditCardPreorder < Transaction
  def self.new_preorder_payment(transacting_user, total_cost, tax_amount, at = Time.zone.now)
    transaction = CreditCardPreorder.new()
    transaction.new_transaction_ledgers( transacting_user, TransactionAccount::CASH_ID, TransactionAccount::ACCOUNTS_RECEIVABLE_ID, total_cost, tax_amount, at)
    transaction
  end

end
