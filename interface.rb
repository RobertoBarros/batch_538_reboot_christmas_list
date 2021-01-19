require 'csv'
# saudacao
puts "---- Welcome to your Christmas list -------"

# Carrega os TODOS salvos no arquivo csv_filepath (todos.csv)
def load_csv(csv_filepath)
  gifts = []
  CSV.foreach(csv_filepath) do |row|
    gifts << row[0] # Nosso csv só tem uma coluna
  end
  return gifts
end

# Salva o CSV no arquivo csv_filepath (todos.csv) sempre apagando e criando novamente
def save_csv(csv_filepath, gifts)
  CSV.open(csv_filepath, 'wb') do |csv|
    gifts.each do |gift| # Itera por cada todo do array com todos os TODOs
      csv << [gift] # Precisa colocar em um array porque o CSV é um array de arrays
    end
  end
end


def list(gifts)
  puts 'No items in list' if gifts.count.zero?

  gifts.each_with_index do |gift, index|
    puts "#{index + 1} - #{gift}"
  end
end

def add(gifts)
  puts 'Which item do you want to add?'
  user_answer = gets.chomp
  gifts << user_answer
  save_csv('gifts.csv', gifts)
end

def delete(gifts)
  list(gifts)
  puts 'Which item number do you like to delete?'
  index = gets.chomp.to_i - 1

  if index.negative? || index > (gifts.count - 1) # Verifica se o index é valido
    puts 'Invalid Number'
  else
    gifts.delete_at(index)
    save_csv('gifts.csv', gifts)
  end
end



gifts = load_csv('gifts.csv')


loop do
  # mostrar o menu list / add / delete / mark)
  puts 'Which action list|add|delete|quit?'
  action = gets.chomp

  case action
  when 'list' then list(gifts)
  when 'add' then add(gifts)
  when 'delete' then delete(gifts)
  when 'quit' then break
  else
    puts 'Invalid action'
  end
end

puts "Goodbye..."


