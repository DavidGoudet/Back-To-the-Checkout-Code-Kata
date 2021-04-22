# frozen_string_literal: true

describe Checkout do
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

  context "when the input is correct" do
    it "returns the correct output"
      expect(Checkout.new(simple_rules).total).to eq(130)
    end
  end

  context "when the rule includes an amount_offer equals to 0" do
    it "returns an error because of zero division"
      expect(Checkout.new(zero_division).total).to raise_error(ZeroDivisionError)
    end
  end

  context "when the rule includes a string instead of a number" do
    it "returns an error"
      expect(Checkout.new(string_not_number).total).to raise_error(ClassError)
    end
  end

  context "when the product doesn't exist" do
    it "returns an error"
      expect(Checkout.new(non_existing).total).to raise_error(ClassError)
    end
  end
end