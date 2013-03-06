ASTERIX_DIVIDER = '*' * 22

module GameView
  def display_boards(boards)
    clear_screen
    move_to_home

    boards.each do |board|
      puts ASTERIX_DIVIDER
      puts board == boards[0] ? '      Your board' : "      AI\'s board"
      puts ASTERIX_DIVIDER
      puts '  1 2 3 4 5 6 7 8 9 10'
      board.playing_field.each do |k, v|
        if board == boards[0]
          puts v.join(' ')
        else
          hide_nums = []
          v.each do |e|
            if e.class == Fixnum
              hide_nums << '.'
            else
              hide_nums << e
            end
          end
          puts hide_nums.join(' ')
        end
      end
      puts ''
      puts board == boards[0] ? 'Your remaining ships' : "AI\'s remaining ships"
      p board.playing_field_values.select { |v| v.is_a?(Integer) }.uniq.sort
      puts ''
    end
  end

  def clear_screen
    print "\e[2J"
  end
   
  def move_to_home
    print "\e[H"
  end
end

module UserView
  def enter_letter
    puts 'Enter a letter:'    
  end

  def enter_number
    puts 'Enter a number:'
  end

  def guess_again
    puts 'You have already guessed that - try again!'
  end

  def wrong_letter
    puts "Please only put in one valid letter."
  end

  def wrong_number
    puts "Please only put in one valid number between 1-10."
  end

  def game_over(boards, board)
    winning_message = ''
    board == boards[0] ? winning_message = 'AI wins!' : winning_message = 'You win!'
    puts "Game over! #{winning_message}"
  end
end

module BoardView
  def miss(boards, board, coordinates)
    pronoun = ''
    boards[0] == board ? pronoun = 'You have' : pronoun = 'AI has'
    puts "#{pronoun} missed at #{coordinates[:row]}#{coordinates[:column]}..."
    sleep(1.0)
  end

  def hit(boards, board, coordinates)
    pronoun = ''
    boards[0] == board ? pronoun = 'You have hit AI' : pronoun = 'AI has hit you'
    puts "#{pronoun} at #{coordinates[:row]}#{coordinates[:column]}!"
    sleep(1.0)
  end

  def sunk_ship(ship, current_player)
    puts "#{current_player} ship #{ship} has been sunk!"
  end
end
