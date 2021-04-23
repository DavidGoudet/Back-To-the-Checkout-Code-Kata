# frozen_string_literal: true
require_relative 'product_calculator'

class InputValidator
  def initialize(rules)
    @rules = rules    
  end

  def validate(product)
    validate_rules
    validate_product product
  end

  private

  def validate_product(product)
    product_rules = ProductCalculator.new(@rules, product).product_rules_extractor
    raise IndexError, "The product doesn't exist" if product_rules.nil?
  end

  def validate_rules
    @rules.each do |rule|
      validate_offers(rule) if rule.key?(:amount_offer)
      raise ArgumentError, "The value of the normal price should be a non-negative integer" unless rule[:normal_price].is_a?(Integer) && !rule[:normal_price].negative?
      raise ArgumentError, "The normal price should be a number" unless rule[:normal_price].is_a?(Integer)
    end
  end

  def validate_offers(rule)
    raise ArgumentError, "The amounts and prices should be numbers" unless rule[:amount_offer].is_a?(Integer) && rule[:price_offer].is_a?(Integer)
    raise ArgumentError, "The amount of the offer should be a number greater than 0" unless rule[:amount_offer].positive?
  end
end
