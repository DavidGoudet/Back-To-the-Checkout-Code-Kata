# frozen_string_literal: true
require_relative 'price_calculator'

class CheckOut

  attr_reader :total

  def initialize(rules)
    @rules = rules
    @total = 0
    @products = {}
  end

  def scan(product)
    validate_product(product)
    @products.key?(product) ? @products[product] += 1 : @products[product] = 1
    update_total
  end

  private

  def validate_product(product)
    raise Exception, "Wrong value" unless true
    return true
  end

  def create_product_hash(products)
    products.chars.inject(Hash.new(0)) { |product, e| product[e] += 1 ;product}
  end

  def update_total
    @total = 0
    @products.each do |product, amount|
      @total += PriceCalculator.new(@rules, product, amount).calculate_price
    end
  end
end
