# frozen_string_literal: true

class Checkout
  attr_reader :total

  def initialize(rules)
    @rules = rules
    @total = 0
  end

  def price(products)
    validate_products(products)

    @total = PriceCalculator.new(rules, product, amount).calculate_price
  end

  def scan(product)
    raise Exception, "Wrong value" unless validate_product(product)

    @total += PriceCalculator.new(rules, product, 1)
  end

  private

  def validate_products(products)
    raise Exception, "Wrong value" unless true
    return true
  end

  def validate_product(product)
  end
end