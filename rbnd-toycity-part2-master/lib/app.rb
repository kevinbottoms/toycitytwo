require 'json'
path = File.join(File.dirname(__FILE__), '../data/products.json')
file = File.read(path)
products_hash = JSON.parse(file)

# Print today's date
date = Time.now.strftime("%d/%m/%y %H:%M")
puts "Date and time report generated: " + date

puts "                     _            _       "
puts "                    | |          | |      "
puts " _ __  _ __ ___   __| |_   _  ___| |_ ___ "
puts "| '_ \\| '__/ _ \\ / _` | | | |/ __| __/ __|"
puts "| |_) | | | (_) | (_| | |_| | (__| |_\\__ \\"
puts "| .__/|_|  \\___/ \\__,_|\\__,_|\\___|\\__|___/"
puts "| |                                       "
puts "|_|                                       "
puts

# For each product in the data set:
  # Print the name of the toy
  # Print the retail price of the toy
  # Calculate and print the total number of purchases
  # Calculate and print the total amount of sales
  # Calculate and print the average price the toy sold for
  # Calculate and print the average discount (% or $) based off the average sales price

products = {}
brands = {}

products_hash["items"].each do |product|
  if brands.keys.include? product["brand"]
    brands[product["brand"]]["stock"] += product["stock"]
    brands[product["brand"]]["amount_sold"] += product["purchases"].length
    product["purchases"].each do |sale|
      brands[product["brand"]]["total_sales"] += sale["price"]
    end
  else
    brands[product["brand"]] = {}
    brands[product["brand"]]["stock"] = product["stock"]
    brands[product["brand"]]["amount_sold"] = product["purchases"].length
    brands[product["brand"]]["total_sales"] = 0.0
    product["purchases"].each do |sale|
      brands[product["brand"]]["total_sales"] += sale["price"]
    end
  end
end

puts brands

	puts " _                         _     "
	puts "| |                       | |    "
	puts "| |__  _ __ __ _ _ __   __| |___ "
	puts "| '_ \\| '__/ _` | '_ \\ / _` / __|"
	puts "| |_) | | | (_| | | | | (_| \\__ \\"
	puts "|_.__/|_|  \\__,_|_| |_|\\__,_|___/"
	puts

# For each brand in the data set:
  # Print the name of the brand
  # Count and print the number of the brand's toys we stock
  # Calculate and print the average price of the brand's toys
  # Calculate and print the total revenue of all the brand's toy sales combined
