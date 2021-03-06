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
    product_rules = ProductCalculator.new(@rules).product_rules_extractor(product)
    raise IndexError, "The product doesn't exist" if product_rules.nil?
  end

  def validate_rules
    raise ArgumentError, "The list of rules should be an array of hashes" unless @rules.is_a?(Array) && @rules.first.is_a?(Hash)

    @rules.each do |rule|
      validate_offers(rule) if rule.key?(:amount_offer)
      is_numeric_and_non_negative = rule[:normal_price].is_a?(Numeric) && !rule[:normal_price].negative?
      raise ArgumentError, "The value of the normal price should be a non-negative number" unless is_numeric_and_non_negative
    end
  end

  def validate_offers(rule)
    raise ArgumentError, "The amount should be an integer" unless rule[:amount_offer].is_a?(Integer)
    raise ArgumentError, "The price should be a number" unless rule[:price_offer].is_a?(Numeric)
    raise ArgumentError, "The amount of the offer should be a number greater than 0" unless rule[:amount_offer].positive?
    raise ArgumentError, "The value of the price_offer should be a non-negative integer" if rule[:price_offer].negative?
  end
end
