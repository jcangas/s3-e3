

class CashMov
  attr_accessor :date
  attr_accessor :payment_type
  attr_accessor :concept
  attr_accessor :amount
  attr_accessor :account_type
  attr_accessor :sale_point
  attr_accessor :salesman


  # Is autoinverse!
  def encode(data)
      mask =   date_to_str8(self[:date]) + self[:concept][0..3]
      encode = (0..7).map { |k| (data[k].ord ^ mask[k].ord).chr }
      result = encode + get_crc(encode)
  end


  class Importer
      def read(file_name)
        csv_records = CSVReader.read(file_name)
        results = []
        cm = CashMov.new
        results << cm

        csv_records.each do |rec|
            # ....

          decoded = cm.encode(rec[4]) #CoA removed

          # ...
        end
        results
  end

  class Exporter
      def write(cash_movs, file_name)
        CSVWriter.write(file_name) do |writer|
          cash_movs.each { |cm|

          # ...

          transaction_code = cm.encode(cm[:sale_point] + cm[:salesman])  #CoA removed

          # ...
        }
      end
  end

end

