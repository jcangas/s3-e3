class CashMov

  # We can protect from CN using a module
  module CSV
    class Importer
      # ...
    end

    class Exporter
      # ...
    end
  end

  # So will can reuse these names

  module XML
    class Importer
      # ...
    end

    class Exporter
      # ...
    end
  end

end

