

class CashMov
  attr_accessor :date
  attr_accessor :payment_type
  attr_accessor :concept
  attr_accessor :amount
  attr_accessor :account_type
  attr_accessor :sale_point
  attr_accessor :salesman

  # Account Types
  AT_REFUND = 0
  AT_DEBIT = 1

  class Importer
    def read(file_name)
      csv_records = CSVReader.read(file_name)
      results = []
      cm = CashMov.new
      results << cm

      csv_records.each do |rec|

        # ...

        #CoM removed. Also contains CoA, but we are doing one Connascense per time
        cm[:account_type] = (cm.amount < 0 ? AT_REFUND : AT_DEBIT)

        # ....

      end
      results
    end
  end
end

