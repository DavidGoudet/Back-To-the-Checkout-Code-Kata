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

  let (:no_normal_price) { 
    [
      {product: 'A', amount_offer: 2, price_offer: 130},
    ]
  }

  let (:no_price_offer) { 
    [
      {product: 'A', normal_price: 50, amount_offer: 2},
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
      expect{ price(mixed_products, zero_division) }.to raise_error(ArgumentError)
    end
  end

  context "when the rule includes a string instead of a number" do
    it "returns an ArgumentError" do
      expect{ price(mixed_products, string_not_number) }.to raise_error(ArgumentError)
    end
  end

  context "when the product doesn't exist" do
    it "returns an IndexError" do
      expect{ price(mixed_products, non_existing) }.to raise_error(IndexError)
    end
  end

  context "when there is no normal price" do
    it "returns an ArgumentError" do
      expect{ price(mixed_products, no_normal_price) }.to raise_error(ArgumentError)
    end
  end

  context "when there's amount offer without price offer" do
    it "returns an ArgumentError" do
      expect{ price(mixed_products, no_price_offer) }.to raise_error(ArgumentError)
    end
  end
end