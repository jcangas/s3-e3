

# I adapted this sample from a real Delhpi project wroted by one of my customers.
# Is a bit messy but, believe it or not I simplified the original code for this sample

# It is not a example for each Connascence type, but I choose it anyway because I think is
# interesting to show the cumulative effect in real code and the cumulative effect of the
# refactorings

class CashMov
  attr_accessor :date
  attr_accessor :payment_type
  attr_accessor :concept
  attr_accessor :amount
  attr_accessor :account_type
  attr_accessor :sale_point
  attr_accessor :salesman

  CSV_COLUMNS = {:date => 0,
    :payment_type => 1,
    :concept => 2,
    :amount => 3,
    :transaction_code => 4}

  class Importer
      def read(file_name)
        csv_records = CSVReader.read(file_name)
        results = []
        cm = CashMov.new
        results << cm

        csv_records.each do |rec|
          # CoP removed introducing named constants

          cm[:date]         = str8_to_date(rec[CSV_COLUMNS[:date])
          cm[:payment_type] = rec[CSV_COLUMNS[:date]]
          cm[:concept]      = rec[CSV_COLUMNS[:date]]
          cm[:amount]       = rec[CSV_COLUMNS[:date]]

          # ....
        end
        results
  end

end

