# frozen_string_literal: true
require_relative 'price_calculator'

class CheckOut

  attr_reader :total

  def initialize(rules)
    validate_rules rules
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
    #pp product
    #raise ZeroDivisionError, "The amount of the offer can't be 0" unless product[:]
    true
  end

  def validate_rules(rules)
    rules.each do |rule|
      raise ZeroDivisionError, "The amount of the offer can't be 0" if rule[:amount_offer] == 0
      #raise StandardError, "The value is not correct" unless rule[:normal_price] =~ /[0..9]*/
    end
  end

  def update_total
    @total = 0
    @products.each do |product, amount|
      @total += PriceCalculator.new(@rules, product, amount).calculate_price
    end
  end
end



ruless = [
      {product: 'A', normal_price: 50, amount_offer: 3, price_offer: 130},
      {product: 'B', normal_price: 30, amount_offer: 2, price_offer: 45},
      {product: 'C', normal_price: 20},
      {product: 'D', normal_price: 15},
    ]

co= CheckOut.new(ruless)
goods = 'AAABBBBDCCD'
goods.split(//).each { |item| co.scan(item) }
p co.total

