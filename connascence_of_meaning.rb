

class CashMov
  attr_accessor :date
  attr_accessor :payment_type
  attr_accessor :concept
  attr_accessor :amount
  attr_accessor :account_type
  attr_accessor :sale_point
  attr_accessor :salesman


  class Importer
      def read(file_name)
        csv_records = CSVReader.read(file_name)
        results = []
        cm = CashMov.new
        results << cm

        csv_records.each do |rec|

            # ...

          #CoM for account_types
          cm[:account_type] = (cm.amount < 0 ? : 0 : 1)

            # ....

        end
        results
  end

end

