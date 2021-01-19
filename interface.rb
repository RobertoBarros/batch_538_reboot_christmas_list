require 'csv'
CSV_FILENAME = 'gifts.csv'

# Carrega os TODOS salvos no arquivo csv_filepath (todos.csv)
def load_csv(csv_filepath)
  gifts = []
  CSV.foreach(csv_filepath) do |row|
    gifts << { item: row[0], bought: row[1] == 'true' }
  end
  return gifts
end

# Salva o CSV no arquivo csv_filepath (todos.csv) sempre apagando e criando novamente
def save_csv(csv_filepath, gifts)
  CSV.open(csv_filepath, 'wb') do |csv|
    gifts.each do |gift| # Itera por cada todo do array com todos os TODOs
      csv << [gift[:item], gift[:bought]] # Precisa colocar em um array porque o CSV é um array de arrays
    end
  end
end

def list(gifts)
  puts 'No items in list' if gifts.count.zero?

  gifts.each_with_index do |gift, index|
    check = gift[:bought] ? '[X]' : '[ ]'
    puts "#{index + 1} - #{check} #{gift[:item]}"
  end
end

def add(gifts)
  puts 'Which item do you want to add?'
  user_answer = gets.chomp
  gifts << { item: user_answer, bought: false }
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
  puts 'Which action list|add|delete|mark|quit?'
  action = gets.chomp

  case action
  when 'list' then list(gifts)
  when 'add' then add(gifts)
  when 'delete' then delete(gifts)
  when 'mark' then mark(gifts)
  when 'quit' then break
  else
    puts 'Invalid action'
  end
end

puts "Goodbye..."


