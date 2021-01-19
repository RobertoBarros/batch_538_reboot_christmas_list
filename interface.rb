# saudacao
puts "---- Welcome to your Christmas list -------"

def list(gifts)
  puts 'No items in list' if gifts.count.zero?

  gifts.each_with_index do |gift, index|
    puts "#{index + 1} - #{gift}"
  end
end

gifts = []

def add(gifts)
  puts 'Which item do you want to add?'
  user_answer = gets.chomp
  gifts << user_answer
end

def delete(gifts)
  list(gifts)
  puts 'Which item number do you like to delete?'
  index = gets.chomp.to_i - 1
  gifts.delete_at(index)
end

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


