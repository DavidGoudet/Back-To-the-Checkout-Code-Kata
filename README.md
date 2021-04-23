# Back to the Checkout

This app uses Ruby to calculate the prices of a list of products being checkout in a supermarket with a given set of pricing rules.  
  
Based on the Code Kata:    
http://codekata.com/kata/kata09-back-to-the-checkout/
## 	Requirements:
```
Ruby 3.0.0
RSpec
```

## Installation
Before running the application it is recommended to use RVM to use the right Ruby version. Once you have the correct version you can install the required gems with:
```
bundle install
```

## Testing
We have two sets of tests in this application:  
The test unit provided by Ruby: *Test::Unit* and another set using *RSpec*  
This decision is following the techniques of design recommended in the book Eloquent Ruby, because RSpecs are not only about the tests but also about the code.

To run the *Test::Unit* just run this in the root of the app:
```
ruby tests.rb
```
To run the *RSpecs* run this in the root of the app:
```
rspec -fd
```
The -fd flag will output the results in a readable format.

## Classes
### CheckOut
This is the main interface of the app. The CheckOut class initializes the rules and validators and ultimately scans the products. This class will receive a set of rules in the form of an array of hashes with the following form:
```
rules = [
  {product: 'A', normal_price: retail_price_a, amount_offer: amount_offer_a, price_offer: price_offer_a},
  {product: 'B', normal_price: retail_price_b},
]
```
**product**: name of the product.  
**normal_price**: price for one unit of the product.  
**amount_offer**: quantity of products to get offer.  
**price_offer**: price of the previosly mentioned products with offer.  

The three types of prices mentioned in the Kata could be written like this:  
*"apples cost 50 cents"*  
{product: 'Apple', normal_price: 0.5},  
  
*"three apples cost $1.30"*  
{product: 'Apple', normal_price: 0.5, amount_offer: 3, price_offer: 1.3}  
  
*"buy two, get one free" (3 apples cost the same as 2 apples)*  
{product: 'Apple', normal_price: 0.5, amount_offer: 3, price_offer: 1}  
  
To scan the products we first validate the inputs (products and prices) and then we create a hash with the consolidated products.
### ProductCalculator
This class has two main goals:  
1- Returning the price of a set of products (E.g.: 12 apples)  
2- Extracting the rules for a given product  
  
To calculate the price of a product we check if the product rules includes offers. If they don't we simply return the amount of products multiplied by its retail price. If the have offers we call the function calculate_price_with_offer.  
  
To calculate the price of products in offer we are calculating the modulo of the amount of products and the amount of products in offer to find out how much the remainder of the division would be, we call this variable: without_offer.  
  
After calculating this, we can calculate the amount of products in offer. Knowing these variables, the price is a simple calculation.

### InputValidator
This class condenses all of the validations we need to do to avoid bad inputs from the user. It's divided in the validations on the products (to be sure that the product exists) and the rules validations.  
  
The rules validations are looking for non-numeric values, non-positive values and different types of numbers to raise errors.
## Other Considerations
* The document mentioned the possibility of having different formats for the pricing rules. The decision of using a hash is related to the possible use of JSON to allow the app to receive any type of structure translated into a JSON object (easily convertible to a hash). Adding a filter before initializing the rules will be enough to use any possible format.

* The supermarket could decide to have different rules for the same product, for example:
-One apple, 50 cents  
-Three apples, $1.3  
-Buy two apples and you'll get one free    
In that case, it will be better to buy 2 apples and get the third for free. To implement that, we'll need to change the calculate_price_with_offer with this logic:  
If the person is buying 6 apples, we calculate the dividers of the apples (1,2,3,6) and calculate the prices for each possible path creating a graph of the possible prices. The node 6 will be connected to the node 3 (multiplying by 2), the node 3 will be connected to two prices: $1.3 and price_of(2). In the end this problem will be a subset of Dijkstra's algorithm.
* If we need to add new rules, like getting a free pear for every two apples we could modify the format of the rules to easily:  
{product: 'Apple', normal_price: 0.5, amount_offer: 2, other_product: 'Pear', other_product_amount: 1}    
After that, we could change the validations to allow the new fields and make small changes to the calculator to allow different products.
* Adding specs for every single class will be necessary for a real-life environment that's subject to constant change.