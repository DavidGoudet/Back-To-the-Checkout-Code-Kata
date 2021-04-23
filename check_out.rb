# frozen_string_literal: true
require_relative 'product_calculator'
require_relative 'input_validator'

class CheckOut
  attr_reader :total

  def initialize(rules)
    @rules = rules
    @total = 0
    @products = {}
    @validator = InputValidator.new(rules)
    @calculator = ProductCalculator.new(@rules)
  end

  def scan(product)
    @validator.validate(product)
    @products.key?(product) ? @products[product] += 1 : @products[product] = 1
    update_total
  end

  private

  def update_total
    @total = 0
    @products.each do |product, amount|
      @total += @calculator.calculate_price(product, amount)
    end
  end
end
