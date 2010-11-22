


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
          # CoP: the position of fields in the file are hardcoded
          cm[:date]         = str8_to_date(rec[0])
          cm[:payment_type] = rec[1] #CoP
          cm[:concept]      = rec[2] #CoP
          cm[:amount]       = rec[3] #CoP

          # ....
        end
        results
  end

end

