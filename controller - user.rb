class User
  attr_reader :already_guessed

  def initialize
    @already_guessed = []
    @coordinates = {}
  end

  def choose_coordinates(interface)
    @coordinates = {}
    interface.enter_letter
    letter_entry = gets.chomp.upcase
    until letter_legit?(letter_entry, interface)
      interface.enter_letter
      letter_entry = gets.chomp.upcase
    end
    interface.enter_number
      number_entry = gets.chomp.to_i
    until number_legit?(number_entry, interface)
      interface.enter_number
      number_entry = gets.chomp.to_i
    end
    @coordinates = {row: letter_entry, column: number_entry}
    duplicate_check(interface)
  end

  def letter_legit?(letter_entry, interface)
    if !!(letter_entry =~ /^[a-jA-J]$/)
      true
    else
      interface.wrong_letter
      false
    end
  end

  def number_legit?(number_entry, interface)
    if number_entry <= 10 && number_entry >= 1
      true
    else
      interface.wrong_number
      false
    end
  end

  def duplicate_check(interface)
    if already_guessed.include?(@coordinates)
      interface.guess_again
      choose_coordinates(interface)
    else
      already_guessed << @coordinates
      @coordinates
    end
  end

end
