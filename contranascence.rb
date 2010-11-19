
##  BEFORE Refact

class CashMov

  # This introduces CN: cannot reuse the constant value, also
  # we can need other named constants with another meaning
  # Example payment_type can be cash = 0, card = 1, check = 2 refund = 3 (we can use a refund for a new purchase), etc

  # Account Types
  AT_REFUND = 0
  AT_DEBIT = 1
end


##  After Refact
## We use namespaces to void colision of indentifiers

class CashMov
  module AccountType
    REFUND = 0
    DEBIT = 1
  end


  module PaymentType
    CASH = 0
    CARD = 1
    CHECK = 2
    REFUND = 3
  end
end

