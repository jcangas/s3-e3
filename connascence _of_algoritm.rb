

class CashMov
  attr_accessor :date
  attr_accessor :payment_type
  attr_accessor :concept
  attr_accessor :amount
  attr_accessor :account_type
  attr_accessor :sale_point
  attr_accessor :salesman

  # Importer and Exporter share knowledge about encode/decode a transaction_code
  # Note encode/decode is an autoinverse function
  class Importer
      def read(file_name)
        csv_records = CSVReader.read(file_name)
        results = []
        cm = CashMov.new
        results << cm

        csv_records.each do |rec|
            # ....

          transaction_code  = rec[4] # with lenght == 9, last chr is a CRC
          mask = rec[0] + cm[:concept][0..3]
          decoded = (0..7).map { |k| (transaction_code[k].ord ^ mask[k].ord).chr } #CoA: see Exporter

            # ....

        end
        results
  end

  class Exporter
      def write(cash_movs, file_name)
        CSVWriter.write(file_name) do |writer|
          cash_movs.each { |cm|

          mask =   date_to_str8(cm[:date]) + cm[:concept][0..3]
          transaction_code = cm[:sale_point] + cm[:salesman]
          encode = (0..7).map { |k| (transaction_code[k].ord ^ mask[k].ord).chr } #CoA
          transaction_code = encode + get_crc(encode)

          # ...
        }
      end
  end

end

