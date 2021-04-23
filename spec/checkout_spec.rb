# frozen_string_literal: true
require_relative '../check_out'

describe CheckOut do
  def price(goods, rules)
    co = CheckOut.new(rules)
    goods.split(//).each { |item| co.scan(item) }
    co.total
  end

  let(:single_rule) { {product: 'A', normal_price: 50, amount_offer: 3, price_offer: 130} }

  let (:simple_rules) { 
    [
      {product: 'A', normal_price: 50, amount_offer: 3, price_offer: 130},
      {product: 'B', normal_price: 30, amount_offer: 2, price_offer: 45},
      {product: 'C', normal_price: 20},
      {product: 'D', normal_price: 15},
    ]
  }

  let (:single_product) { 'AAA' }
  let (:mixed_products) { 'AAABBAACDCA' }
  let (:zero_products) { '' }

  context "when the input is correct" do
    context "and the input is a single product" do
      it "returns the correct sum" do
        expect(price(single_product, simple_rules)).to eq(130)
      end
    end

    context "and the input is zero products" do
      it "returns 0" do
        expect(price(zero_products, simple_rules)).to eq(0)
      end
    end

    context "and the input is mixed" do
      it "returns the correct sum" do
        expect(price(mixed_products, simple_rules)).to eq(360)
      end
    end
  end

  context "when the rule includes an amount_offer equals to 0" do
    it "returns an error because of zero division" do
      single_rule[:amount_offer] = 0
      expect{ price(mixed_products, [single_rule]) }.to raise_error(ArgumentError, "The amount of the offer should be a number greater than 0")
    end
  end

  context "when the rule includes a string instead of a number" do
    it "returns an ArgumentError" do
      single_rule[:normal_price] = 'string'
      expect{ price(mixed_products, [single_rule]) }.to raise_error(ArgumentError, "The value of the normal price should be a non-negative integer")
    end
  end

  context "when the product doesn't exist" do
    it "returns an IndexError" do
      single_rule[:product] = 'ZZ'
      expect{ price(mixed_products, [single_rule]) }.to raise_error(IndexError, "The product doesn't exist")
    end
  end

  context "when there is no normal price" do
    it "returns an ArgumentError" do
      single_rule.tap { |sr| sr.delete(:normal_price) }
      expect{ price(mixed_products, [single_rule]) }.to raise_error(ArgumentError, "The value of the normal price should be a non-negative integer")
    end
  end

  context "when there's amount offer without price offer" do
    it "returns an ArgumentError" do
      single_rule.tap { |sr| sr.delete(:price_offer) }
      expect{ price(mixed_products, [single_rule]) }.to raise_error(ArgumentError, "The amounts and prices should be numbers")
    end
  end
end