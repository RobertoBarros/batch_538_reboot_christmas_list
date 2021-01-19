# saudacao
puts "---- Welcome to your Christmas list -------"

def list(gifts)
  puts 'No items in list' if gifts.count.zero?

  gifts.each_with_index do |gift, index|
    puts "#{index + 1} - #{gift}"
  end
end

gifts = []

action = nil
# condicao de pergunta e acao
while action != 'quit'
  # mostrar o menu list / add / delete / mark)
  puts 'Which action list|add|quit?'
  action = gets.chomp

  case action
  when 'list' then list(gifts)
  else
    puts "Invalid action"
  end

end

