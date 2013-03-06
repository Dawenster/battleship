class TurnsController
  attr_reader :game

  def initialize(options = {})
    ai = AI.new
    user = User.new
    @game = Game.new(
      user_board: Board.new(owner: user), 
      ai_board: Board.new(owner: ai), 
      ai: ai, 
      user: user
    )
  end

  def run
    game.display_boards(boards)
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
