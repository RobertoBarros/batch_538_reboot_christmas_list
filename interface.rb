#saudacao
puts " Welcome to your Christmas list"
#mostrar o menulist/ add/ delete/ mark)
action = nil

# condicao de pergunta e acao
while action != "quit"
  puts "Which action [list|add|delete|quit]?"
  action = gets.chomp
end

