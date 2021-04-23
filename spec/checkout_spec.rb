# frozen_string_literal: true
require_relative '../check_out'

describe CheckOut do
  def price(goods, rules)
    co = CheckOut.new(rules)
    goods.split(//).each { |item| co.scan(item) }
    co.total
  end

  let (:simple_rules) { 
    [
      {product: 'A', normal_price: 50, amount_offer: 3, price_offer: 130},
      {product: 'B', normal_price: 30, amount_offer: 2, price_offer: 45},
      {product: 'C', normal_price: 20},
      {product: 'D', normal_price: 15},
    ]
  }
  let (:zero_division) { 
    [
      {product: 'A', normal_price: 50, amount_offer: 0, price_offer: 130},
    ]
  }
  let (:string_not_number) { 
    [
      {product: 'A', normal_price: 'string', amount_offer: 2, price_offer: 130},
    ]
  }
  let (:non_existing) { 
    [
      {product: 'Z', normal_price: 50, amount_offer: 2, price_offer: 130},
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
      expect{ CheckOut.new(zero_division) }.to raise_error(ZeroDivisionError, "The amount of the offer can't be 0")
    end
  end

  context "when the rule includes a string instead of a number" do
    it "returns an error" do
      expect(CheckOut.new(string_not_number).total).to raise_error(ClassError)
    end
  end

  context "when the product doesn't exist" do
    it "returns an error" do
      expect(CheckOut.new(non_existing).total).to raise_error(ClassError)
    end
  end
end