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
    @attack_coords = {}
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

  def take_turns
    game.players.each do |player|
      @attack_coords[player] = player.choose_coordinates
    end
  end

  def other_board(not_board)
    game.boards.find {|b| b != not_board }
  end

  def draw_attacks
    game.boards.each do |board|
      coordinates = @attack_coords[board.owner]
      other_board(board).draw_attack(coordinates, board.owner)
    end
  end
end
