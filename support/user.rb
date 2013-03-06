class User
  include UserView
  attr_reader :already_guessed

  def initialize
    @already_guessed = []
    @coordinates = {}
  end

  def choose_coordinates
    @coordinates = {}
    enter_letter
    letter_entry = gets.chomp.upcase
    until letter_legit?(letter_entry)
      enter_letter
      letter_entry = gets.chomp.upcase
    end
    enter_number
      number_entry = gets.chomp.to_i
    until number_legit?(number_entry)
      enter_number
      number_entry = gets.chomp.to_i
    end
    @coordinates = {row: letter_entry, column: number_entry}
    duplicate_check
  end

  def letter_legit?(letter_entry)
    if !!(letter_entry =~ /^[a-jA-J]$/)
      true
    else
      wrong_letter
      false
    end
  end

  def number_legit?(number_entry)
    if number_entry <= 10 && number_entry >= 1
      true
    else
      wrong_number
      false
    end
  end

  def duplicate_check
    if already_guessed.include?(@coordinates)
      guess_again
      choose_coordinates
    else
      already_guessed << @coordinates
      @coordinates
    end
  end

end
