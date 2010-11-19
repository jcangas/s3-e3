class CashMov
  CSV_COLUMNS = {:date => 0,
    :payment_type => 1,
    :concept => 2,
    :amount => 3,
    :transaction_code => 4}

  # Account Types
  AT_REFUND = 0
  AT_DEBIT = 1

  attr_accessor :date
  attr_accessor :payment_type
  attr_accessor :concept
  attr_accessor :amount
  attr_accessor :account_type
  attr_accessor :sale_point
  attr_accessor :salesman

  def encode(data)
      mask =   date_to_str8(self[:date]) + self[:concept][0..3]
      encode = (0..7).map { |k| (data[k].ord ^ mask[k].ord).chr }
      result = encode + get_crc(encode)
  end

  def account_type_for(x)
    (x < 0 ? : AT_REFUND : AT_DEBIT) #CoM removed
  end

  def amount_to_money
    case cm[:account_type]
      when AT_REFUND
        -1 * cm[:amount]
      when AT_DEBIT
        cm[:amount]
    end
  end

  class Importer

      def extract_salepoint(decoded)
        decoded[0..3]
      end

      def extract_salesman(decoded)
        decoded[4..7]
      end

      def read(file_name)
        #Pretends CSVReader is some class to parse csv files as array of arrays of values
        csv_records = CSVReader.read(file_name)
        results = []
        cm = CashMov.new
        results << cm

        csv_records.each do |rec|
          cm[:date]         = str8_to_date(rec[CSV_COLUMNS[:date]) #CoP removed
          cm[:payment_type] = rec[CSV_COLUMNS[:date]] #CoP removed
          cm[:concept]      = rec[CSV_COLUMNS[:date]] #CoP removed
          cm[:amount]       = rec[CSV_COLUMNS[:date]] #CoP removed
          cm[:account_type] = account_type_for(cm.amount) #CoA removed

          decoded = cm.encode(rec[4]) #CoA removed

          cm[:sale_point] = extract_salepoint(decoded) #CoP removed
          cm[:salesman] = extract_salesman(decoded) #CoP remvoved
        end
        results
  end

  class Exporter

      def write(cash_movs, file_name)
        CSVWriter.write(file_name) do |writer|
          cash_movs.each { |cm|
          amount = cm.amount_to_money
          transaction_code = cm.encode(cm[:sale_point] + cm[:salesman])  #CoA removed

          rec = []
          rec[CSV_COLUMNS[:date]] = cm[:date]
          rec[CSV_COLUMNS[:payment_type]] = cm[:payment_type]
          rec[CSV_COLUMNS[:concept]] = cm[:concept]
          rec[CSV_COLUMNS[:amount]] = amount
          rec[CSV_COLUMNS[:transaction_code]] = transaction_code

          write.write(rec) #CoP removed
        }
      end
  end

end

