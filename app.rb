require "sinatra"
require "sinatra/reloader"
require "sinatra/activerecord"
require "./lib/purchase"
require "./lib/product"
require "pry"

also_reload "lib/**/*.rb"

get "/" do
  erb :index
end

get '/manager_portal' do
  @all_products = Product.all
  erb :manager_portal
end

post '/product/new' do
  item_name = params['product_name']
  item_description = params['product_description']
  item_cost = params['product_cost'].to_i
  Product.new({name: item_name, description: item_description, cost: item_cost, is_purchased: false}).save
  redirect '/manager_portal'
end

get '/product/:id' do
  @product = Product.find(params['id'].to_i)
  erb :product
end

patch '/product/:id/edit' do
  product = Product.find(params['id'].to_i)
  new_name = params.fetch('edit-name')
  if new_name == ""
    new_name = product.name
  end
  new_description = params.fetch("edit-description")
  if new_description == ""
    new_description = product.description
  end
  new_cost = params.fetch('edit-cost', product.cost)
  if new_cost == ""
    new_cost = product.cost
  end
  product.update({:name => new_name, :description => new_description, :cost => new_cost})
  redirect "/product/#{product.id}"
end

delete '/product/:id/delete' do
  product = Product.find(params['id'].to_i)
  product.delete
  redirect "/manager_portal"
end

# --------------------- CASHIER PORTAL
# --------------------- CASHIER PORTAL
# --------------------- CASHIER PORTAL

get '/cashier_portal' do
  @all_products = Product.all
  erb :cashier_portal
end

patch '/checkout' do
  @returned = []
  new_purchase = Purchase.create
  selected_products = params['purchased-items']
  if selected_products != nil
  selected_products.map { |product|
    found_product = Product.find(product.to_i)
     found_product.update(is_purchased: true)
     found_product.update(purchase_id: new_purchase.id)
     @returned.push(found_product)
   }
   erb :checkout
  else
    redirect '/cashier_portal'
  end

end

patch '/return' do
  returned_products = params['returned-items']
  returned_products.map { |product|
    found_product = Product.find(product.to_i)
     found_product.update(is_purchased: false)
   }
  redirect '/manager_portal'
end
