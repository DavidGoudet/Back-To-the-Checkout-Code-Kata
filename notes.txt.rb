# Just for notes

#Final
#Every Rule will be translated like:
#Rule.new(A, 50, 3, 120)
normal_price = 50
amount_offer = 3 #could never be 0
price_offer = 120
products = "AAAA"
na = 7

modulo = na % amount_offer
in_offer = na - modulo
price = (in_offer / amount_offer) * price_offer + modulo * normal_price
p price

#EndFinal

class Rules
  def initialize(product, normal_price, amount_offer=nil, price_offer=nil)
    @product = product
    @normal_price = normal_price
    @amount_offer = amount_offer
    @price_offer = price_offer
  end

  private
end

Rules.new(:m, :retail, 1, 1)
Rules.new(:m, :whole, 2, 1.5)
Rules.new(:m, :free, 3, 2)

#Errors
Rules(12, 34, nil, :test)
Rules(:m, :retail, -2, 3)
Rules(:m, :retailss, 2, 3)


#Got two, one free
Rules.new(:m, 3, CalculatePrice(2))

#The other way
Rules.new(:m, 3, :2)
Rules.new(:m, 2, 1.2)
Rules.new(:m, 2, 1.1)

price("MMMMMM")
M=6
look dividers
check dividers rules
calculatePrice()
  for divisor in divisores:
    min_price = -1
    if divisor in rulesofthisitem:
      min_price = if direct return price else calculatePrice(:2)
    else:
      not a price



M = 1
2M = 1.5
3M = 1.5
2M = 1.2


bundle install --path .bundle