ENV["RACK_ENV"] = "test"

require "rspec"
require "pg"
require "pry"
require "sinatra/activerecord"
require "product"
require "purchase"

RSpec.configure do |config|
  config.after(:each) do
    Product.all.each do |d|
      d.destroy
    end
    Purchase.all.each do |d|
      d.destroy
    end
  end
end
