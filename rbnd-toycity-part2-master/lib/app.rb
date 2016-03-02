require 'json'

def setup_files
  path = File.join(File.dirname(__FILE__), '../data/products.json')
  file = File.read(path)
  $products_hash = JSON.parse(file)
  $report_file = File.new("report.txt", "w+")
end

def print_date
  date = Time.now.strftime("%d/%m/%y %H:%M")
  puts "Date and time report generated: " + date
end

def print_products_ascii
  puts "                     _            _       "
  puts "                    | |          | |      "
  puts " _ __  _ __ ___   __| |_   _  ___| |_ ___ "
  puts "| '_ \\| '__/ _ \\ / _` | | | |/ __| __/ __|"
  puts "| |_) | | | (_) | (_| | |_| | (__| |_\\__ \\"
  puts "| .__/|_|  \\___/ \\__,_|\\__,_|\\___|\\__|___/"
  puts "| |                                       "
  puts "|_|                                       "
  puts
end

# For each product in the data set:
  # Print the name of the toy
  # Print the retail price of the toy
  # Calculate and print the total number of purchases
  # Calculate and print the total amount of sales
  # Calculate and print the average price the toy sold for
  # Calculate and print the average discount (% or $) based off the average sales price

def create_products_hash
  toys = {}
  $products_hash["items"].each do |product|
    toys[product["title"]] = {}
		toys[product["title"]]["retail_price"] = product["full-price"]
		toys[product["title"]]["amount_sold"] = product["purchases"].length
		toys[product["title"]]["total_sales"] = 0.0
		product["purchases"].each do |sales|
      toys[product["title"]]["total_sales"] += sales["price"]
		end
	end
	return toys
end

def create_brands_hash
	brands = {}
  $products_hash["items"].each do |product|
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
	return brands
end



def print_brands_ascii
	puts " _                         _     "
	puts "| |                       | |    "
	puts "| |__  _ __ __ _ _ __   __| |___ "
	puts "| '_ \\| '__/ _` | '_ \\ / _` / __|"
	puts "| |_) | | | (_| | | | | (_| \\__ \\"
	puts "|_.__/|_|  \\__,_|_| |_|\\__,_|___/"
	puts
end



# For each brand in the data set:
  # Print the name of the brand
  # Count and print the number of the brand's toys we stock
  # Calculate and print the average price of the brand's toys
  # Calculate and print the total revenue of all the brand's toy sales combined

setup_files()

brands = create_brands_hash()
toys = create_products_hash()
puts brands
puts toys
