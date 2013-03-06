class TurnsController
  attr_reader :game
  def initialize(options = {})
    @game = options[:game]
  end

  def run
    user_board.place_all_the_ships
    ai_board.place_all_the_ships
    display_boards(boards)
    until all_ships_sunk?
      take_turns
      draw_attacks
      display_boards(boards)
      check_sunk_ships?
    end
  end

  def method_missing(*args)
    game.send(*args)
  end
end
