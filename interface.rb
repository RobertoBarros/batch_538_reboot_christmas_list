require 'csv'
require 'open-uri'
require 'nokogiri'

CSV_FILENAME = 'gifts.csv'

# Carrega os TODOS salvos no arquivo csv_filepath (todos.csv)
def load_csv(csv_filepath)

  # gifts é um array de hash
  # gifts = [
  #            {item: 'iphone', bought: false, price: 100},
  #            {item: 'meias', bought: true, price: 20}
  #         ]
  gifts = []
  CSV.foreach(csv_filepath) do |row|
    gifts << { item: row[0], bought: row[1] == 'true', price: row[2] } #Transformar cada linha do CSV em um Hash
  end
  return gifts
end

# Salva o CSV no arquivo csv_filepath (todos.csv) sempre apagando e criando novamente
def save_csv(csv_filepath, gifts)
  CSV.open(csv_filepath, 'wb') do |csv|
    gifts.each do |gift| # Itera por cada todo do array com todos os TODOs
      csv << [gift[:item], gift[:bought], gift[:price]] # Precisa colocar em um array porque o CSV é um array de arrays
    end
  end
end

def list(gifts)
  puts 'No items in list' if gifts.count.zero?

  gifts.each_with_index do |gift, index|
    check = gift[:bought] ? '[X]' : '[ ]'
    puts "#{index + 1} - #{check} #{gift[:item]} R$#{gift[:price]}"
  end
end

def add(gifts)
  puts 'Which item do you want to add?'
  item = gets.chomp
  puts 'Enter item price'
  price = gets.chomp
  gifts << { item: item, bought: false, price: price }
  save_csv(CSV_FILENAME, gifts)
end

def delete(gifts)
  list(gifts)
  puts 'Which item number do you like to delete?'
  index = gets.chomp.to_i - 1

  if index.negative? || index > (gifts.count - 1) # Verifica se o index é valido
    puts 'Invalid Number'
  else
    gifts.delete_at(index)
    save_csv(CSV_FILENAME, gifts)
  end
end

def mark(gifts)
  list(gifts)
  puts 'which item number do you want to mark?'
  index = gets.chomp.to_i - 1

  # gifts[2] => {item: 'iphone', bought: false}
  # gifts[2][:bought] => false
  # gifts[2][:bought] = true => {item: 'iphone', bought: true}
  gifts[index][:bought] = true
  list(gifts)
  save_csv(CSV_FILENAME, gifts)
end

def scraper(gifts)
  puts 'Enter the product to search:'
  product = gets.chomp
  url = "https://www.amazon.com.br/s?k=#{product}"

  html_file = open(url).read
  html_doc = Nokogiri::HTML(html_file)

  products = []

  html_doc.search('.s-result-item').each do |element| # Cada produto
    price = element.search('.a-price-whole').text.strip
    next if price == ''
    cents = element.search('.a-price-fraction').text.strip
    name = element.search('h2').text.strip

    products << { name: name, price: "#{price}#{cents}" }
  end

  products.first(10).each_with_index do |product, index|
    puts "#{index + 1} - #{product[:name]} | R$ #{product[:price]}"
  end

  puts 'Enter product number to add:'
  index = gets.chomp.to_i - 1

  gifts << { item: products[index][:name],
             price: products[index][:price],
             bought: false }

  save_csv(CSV_FILENAME, gifts)
end

##### O programa começa aqui #############

if File.exist?(CSV_FILENAME) # Verifica se o arquivo de CSV existe
  gifts = load_csv(CSV_FILENAME)
else
  gifts = []
end

# saudacao
puts "---- Welcome to your Christmas list -------"


loop do
  # mostrar o menu list / add / delete / mark)
  puts 'Which action list|add|delete|mark|scraper|quit?'
  action = gets.chomp

  case action
  when 'list' then list(gifts)
  when 'add' then add(gifts)
  when 'delete' then delete(gifts)
  when 'mark' then mark(gifts)
  when 'scraper' then scraper(gifts)
  when 'quit' then break
  else
    puts 'Invalid action'
  end
end

puts "Goodbye..."


