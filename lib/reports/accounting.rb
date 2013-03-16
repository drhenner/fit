require 'chronic'
require 'csv'

module ROReReports
  class Accounting
    def initialize(start_time, end_time)
      @start_time = start_time
      @end_time   = end_time
      @ledgers = TransactionLedger.where("created_at >= ? AND created_at <= ?", start_time, end_time).all
    end

    def self.generate_csv

      csv_string = CSV.generate do |csv|
         csv << ["Id", "Account", "Debit","Credit", 'Tax', 'State', 'Period']
         TransactionLedger.find_each do |ledger|
           csv << [ ledger.id,
                    ledger.transaction_account_name,
                    ledger.debit,
                    ledger.credit,
                    ledger.tax_amount,
                    ledger.tax_state_name,
                    ledger.period ]
         end
      end

         #send_data csv_string,
         #:type => 'text/csv; charset=iso-8859-1; header=present',
         #:disposition => "attachment; filename=users.csv"
    end

    def revenue
      @ledgers.sum(&:revenue)
    end

    def cash
      @ledgers.sum(&:cash)
    end

    def accounts_receivable
      @ledgers.sum(&:accounts_receivable)
    end

    def accounts_payable
      @ledgers.sum(&:accounts_payable)
    end

    def start_time
      @start_time
    end

    def end_time
      @end_time
    end
  end
end
