

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

  #Pretends CSVReader / CSVWriter is some class to parse / write csv files using array of arrays of values

  class Importer
      def read(file_name)
        csv_records = CSVReader.read(file_name)
        results = []
        cm = CashMov.new
        results << cm

        csv_records.each do |rec|
          cm[:date]         = str8_to_date(rec[0]) #CoP
          cm[:payment_type] = rec[1] #CoP
          cm[:concept]      = rec[2] #CoP
          cm[:amount]       = rec[3] #CoP
          cm[:account_type] = (cm.amount < 0 ? : 0 : 1)  #CoA + #CoM


          transaction_code  = rec[4] # with lenght == 9, last chr is a CRC
          mask = rec[0] + cm[:concept][0..3]
          decoded = (0..7).map { |k| (transaction_code[k].ord ^ mask[k].ord).chr } #CoA: see it in Exporter class

          cm[:sale_point] = decoded[0..3] #CoP (also CoM ??)
          cm[:salesman] = decoded[4..7] #CoP (also CoM ??)
        end
        results
  end

  class Exporter
      def write(cash_movs, file_name)
        CSVWriter.write(file_name) do |writer|
          cash_movs.each { |cm|
          amount = cm[:account_type] > 0 ? cm[:amount] : -1 * cm[:amount]
          mask =   date_to_str8(cm[:date]) + cm[:concept][0..3]

          transaction_code = cm[:sale_point] + cm[:salesman]
          encode = (0..7).map { |k| (transaction_code[k].ord ^ mask[k].ord).chr } #CoA
          transaction_code = encode + get_crc(encode)
          write.write([ cm[:date], cm[:payment_type], cm[:concept],
                        amount, transaction_code])  #CoP
        }
      end
  end

end

