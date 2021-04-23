# frozen_string_literal: true

require_relative '../check_out'

describe CheckOut do
  def price(goods, rules)
    co = CheckOut.new(rules)
    goods.split(//).each { |item| co.scan(item) }
    co.total
  end

  let(:single_rule) { { product: 'A', normal_price: 50, amount_offer: 3, price_offer: 130 } }

  let(:simple_rules) do
    [
      { product: 'A', normal_price: 50, amount_offer: 3, price_offer: 130 },
      { product: 'B', normal_price: 30, amount_offer: 2, price_offer: 45 },
      { product: 'C', normal_price: 20 },
      { product: 'D', normal_price: 15 }
    ]
  end

  let(:single_product) { 'AAA' }
  let(:single_product_multiple) { 'AAAAA' }
  let(:mixed_products) { 'AAABBAACDCA' }
  let(:zero_products) { '' }

  context 'when the input is correct' do
    context 'and the input is a single product' do
      it 'returns the correct sum' do
        expect(price(single_product, simple_rules)).to eq(130)
      end
    end

    context 'and the input is zero products' do
      it 'returns 0' do
        expect(price(zero_products, simple_rules)).to eq(0)
      end
    end

    context 'and the input is mixed' do
      it 'returns the correct sum' do
        expect(price(mixed_products, simple_rules)).to eq(360)
      end
    end

    context 'and the input is a decimal' do
      it 'returns the correct sum' do
        single_rule[:normal_price] = 50.23
        single_rule[:price_offer] = 129.4
        expect(price(single_product_multiple, [single_rule])).to eq(229.86)
      end
    end

    context 'when there are free products' do
      it 'returns the right price' do
        # Buy two As, get one free
        single_rule[:price_offer] = 100
        expect(price(single_product_multiple, [single_rule])).to eq(200)
      end
    end
  end

  context 'when the rule includes an amount_offer equals to 0' do
    it 'returns an error because of zero division' do
      single_rule[:amount_offer] = 0
      expect do
        price(mixed_products,
              [single_rule])
      end.to raise_error(ArgumentError, 'The amount of the offer should be a number greater than 0')
    end
  end

  context 'when the rule includes a string instead of a number' do
    it 'returns an ArgumentError' do
      single_rule[:normal_price] = 'string'
      expect do
        price(mixed_products,
              [single_rule])
      end.to raise_error(ArgumentError, 'The value of the normal price should be a non-negative number')
    end
  end

  context "when the product doesn't exist" do
    it 'returns an IndexError' do
      single_rule[:product] = 'ZZ'
      expect { price(mixed_products, [single_rule]) }.to raise_error(IndexError, "The product doesn't exist")
    end
  end

  context 'when there is no normal price' do
    it 'returns an ArgumentError' do
      single_rule.tap { |sr| sr.delete(:normal_price) }
      expect do
        price(mixed_products,
              [single_rule])
      end.to raise_error(ArgumentError, 'The value of the normal price should be a non-negative number')
    end
  end

  context "when there's amount offer without price offer" do
    it 'returns an ArgumentError' do
      single_rule.tap { |sr| sr.delete(:price_offer) }
      expect { price(mixed_products, [single_rule]) }.to raise_error(ArgumentError, 'The price should be a number')
    end
  end
end
