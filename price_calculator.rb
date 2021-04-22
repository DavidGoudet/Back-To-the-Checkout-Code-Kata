# frozen_string_literal: true

class PriceCalculator
  def initialize(rules, product, amount)
    @rules = rules
    @product = product
    @amount = amount
  end

  def calculate_price
    product_rules = @rules.find {|rule| rule[:product] == @product }
    amount_offer = product_rules[:amount_offer]
    price_offer = product_rules[:price_offer]
    normal_price = product_rules[:normal_price]

    without_offer = @amount % amount_offer
    with_offer = @amount - without_offer

    return (with_offer / amount_offer) * price_offer + without_offer * normal_price
  end
end