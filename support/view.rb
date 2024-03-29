ASTERIX_DIVIDER = '*' * 22

module GameView
  def display_boards
    clear_screen
    move_to_home

    boards.each do |board|
      board.display_board
    end
  end

  def clear_screen
    print "\e[2J"
  end
   
  def move_to_home
    print "\e[H"
  end

  def game_over(owner)
    puts "Game over! #{owner.as_subject} win!"
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

end

module BoardView
  def display_board
    puts ASTERIX_DIVIDER
    puts "      #{owner.as_possessive} board"
    puts ASTERIX_DIVIDER
    puts '  1 2 3 4 5 6 7 8 9 10'
    playing_field.each do |k, v|
      if self.owner.user?
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
    puts "#{owner.as_possessive} remaining ships"
    p playing_field_values.select { |v| v.is_a?(Integer) }.uniq.sort
    puts ''
  end

  def sunk_ship(ship)
    puts "#{owner.as_possessive} ship #{ship} has been sunk!"
  end
end

module TurnsView
  def puts_hit_miss(coordinates, user, word)
    puts "#{user.as_subject} #{word} at #{coordinates[:row]}#{coordinates[:column]}..."
    sleep(1.0)
  end
end
