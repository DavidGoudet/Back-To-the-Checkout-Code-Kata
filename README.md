# Back to the Checkout

This app uses Ruby to calculate the prices of a list of products being checkout in a supermarket with a given set of pricing rules.  
Based on the Code Kata: http://codekata.com/kata/kata09-back-to-the-checkout/
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
*CheckOut*  
*ProductCalculator*  
*InputValidator*