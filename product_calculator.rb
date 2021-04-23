# frozen_string_literal: true

class ProductCalculator
  def initialize(rules)
    @rules = rules
  end

  def calculate_price(product, amount)
    product_rules = product_rules_extractor(product)

    if product_rules.key?(:amount_offer) && product_rules.key?(:price_offer)
      calculate_price_with_offer(product_rules, amount)
    else
      amount * product_rules[:normal_price]
    end
  end

  def product_rules_extractor(product)
    @rules.find { |rule| rule[:product] == product }
  end

  private

  def calculate_price_with_offer(product_rules, amount)
    amount_offer = product_rules[:amount_offer]
    price_offer = product_rules[:price_offer]
    normal_price = product_rules[:normal_price]

    without_offer = amount % amount_offer
    with_offer = amount - without_offer

    (with_offer / amount_offer) * price_offer + without_offer * normal_price
  end
end
