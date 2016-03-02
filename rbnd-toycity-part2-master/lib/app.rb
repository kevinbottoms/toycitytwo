require 'json'

def setup_files
  path = File.join(File.dirname(__FILE__), '../data/products.json')
  file = File.read(path)
  $products_hash = JSON.parse(file)
  $report_file = File.new("report.txt", "w+")
end # end setup_files method

def print_date
  date = Time.now.strftime("%d/%m/%y %H:%M")
  $report_file.write("Sales Report\n")
  $report_file.write("Date and time report generated: " + date)
  $report_file.write("\n")
end # end print_date method

def print_products_ascii
  $report_file.write("                     _            _       \n")
  $report_file.write("                    | |          | |      \n")
  $report_file.write(" _ __  _ __ ___   __| |_   _  ___| |_ ___ \n")
  $report_file.write("| '_ \\| '__/ _ \\ / _` | | | |/ __| __/ __|\n")
  $report_file.write("| |_) | | | (_) | (_| | |_| | (__| |_\\__ \\\n")
  $report_file.write("| .__/|_|  \\___/ \\__,_|\\__,_|\\___|\\__|___/\n")
  $report_file.write("| |                                       \n")
  $report_file.write("|_|                                       \n")
  $report_file.write("\n")
end # end print_products_ascii

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
    toys[product["title"]]["average_discount"] = 0.0
		product["purchases"].each do |sales|
      toys[product["title"]]["total_sales"] += sales["price"]
		end # end total_sales loop
    toys[product["title"]]["average_price"] =
    toys[product["title"]]["total_sales"] /
    toys[product["title"]]["amount_sold"]

    toys[product["title"]]["average_discount"] = 100 -
    (toys[product["title"]]["average_price"].to_f /
    toys[product["title"]]["retail_price"].to_f * 100)
  end # end each loop to create_products_hash
	return toys
end # end create_products_hash method

def print_toys_hash(list)
  list.each do |key, value|
    $report_file.write("\n#{key}\n")
    $report_file.write("Retail Price: $#{value["retail_price"]}\n")
    $report_file.write("Amount Sold: #{value["amount_sold"]}\n")
    $report_file.write("Total Sales: $#{'%.2f' % value["total_sales"]}\n")
    $report_file.write("Average Price: $#{'%.2f' % value["average_price"]}\n")
    $report_file.write("Average Discount: #{'%.2f' % value["average_discount"]}%\n")
  end # end each loop iterating through toys hash
end # end print_toys_hash method

def create_brands_hash
	brands = {}
  $products_hash["items"].each do |product|
    if brands.keys.include? product["brand"]
      brands[product["brand"]]["stock"] += product["stock"]
      brands[product["brand"]]["amount_sold"] += product["purchases"].length
      product["purchases"].each do |sale|
        brands[product["brand"]]["total_sales"] += sale["price"]
      end # end each loop to calculate total_sales
    else
      brands[product["brand"]] = {}
      brands[product["brand"]]["stock"] = product["stock"]
      brands[product["brand"]]["amount_sold"] = product["purchases"].length
      brands[product["brand"]]["total_sales"] = 0.0
      product["purchases"].each do |sale|
        brands[product["brand"]]["total_sales"] += sale["price"]
      end # end each loop to calculate total_sales
    end # end if to check if brand is already in brands hash
    brands[product["brand"]]["average_price"] =
    brands[product["brand"]]["total_sales"] /
    brands[product["brand"]]["amount_sold"]
  end # end each loop to create_brands_hash
	return brands
end # end create_brands_hash method

def print_brands_hash(list)
  list.each do |key, value|
    $report_file.write("\n#{key}\n")
    $report_file.write("Items In Stock: #{value["stock"]}\n")
    $report_file.write("Average Price: $#{'%.2f' % value["average_price"]}\n")
    $report_file.write("Total Sales: $#{'%.2f' % value["total_sales"]}\n")
  end # end each loop iterating through toys hash
end # end print_brands_hash method

def print_brands_ascii
  $report_file.write("\n")
	$report_file.write(" _                         _     \n")
	$report_file.write("| |                       | |    \n")
	$report_file.write("| |__  _ __ __ _ _ __   __| |___ \n")
	$report_file.write("| '_ \\| '__/ _` | '_ \\ / _` / __|\n")
	$report_file.write("| |_) | | | (_| | | | | (_| \\__ \\\n")
	$report_file.write("|_.__/|_|  \\__,_|_| |_|\\__,_|___/\n")
	$report_file.write("\n")
end # end print_brands_ascii method

# For each brand in the data set:
  # Print the name of the brand
  # Count and print the number of the brand's toys we stock
  # Calculate and print the average price of the brand's toys
  # Calculate and print the total revenue of all the brand's toy sales combined

def create_report()
  $report_file.truncate(0)
  print_date()
  brands = create_brands_hash()
  toys = create_products_hash()
  print_products_ascii()
  print_toys_hash(toys)
  print_brands_ascii()
  print_brands_hash(brands)
  $report_file.close
end # end create_report method

def start()
  setup_files()
  create_report()
end # end start method

start()
