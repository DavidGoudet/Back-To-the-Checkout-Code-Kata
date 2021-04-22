# frozen_string_literal: true

class Rules
  def initialize(product, normal_price, amount_offer=nil, price_offer=nil)
    @product = product
    @normal_price = normal_price
    @amount_offer = amount_offer
    @price_offer = price_offer
  end
end