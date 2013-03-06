class TurnsController
  attr_reader :game

  def initialize(options = {})
    @game = Game.new(user_board: Board.new, ai_board: Board.new, ai: AI.new, user: User.new)
  end

  def run
    game.user_board.place_all_the_ships
    game.ai_board.place_all_the_ships
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
