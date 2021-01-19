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

loop do
  # mostrar o menu list / add / delete / mark)
  puts 'Which action list|add|quit?'
  action = gets.chomp

  case action
  when 'list' then list(gifts)
  when 'add' then add(gifts)
  when 'quit' then break
  else
    puts 'Invalid action'
  end
end

puts "Goodbye..."


