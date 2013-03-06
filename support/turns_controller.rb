class TurnsController
  include TurnsView
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

  def boards
    game.boards
  end

  def run
    game.display_boards
    until all_ships_sunk?
      take_turns
      draw_attacks
      game.display_boards
      check_for_sunk_ships
    end
  end

  def check_for_sunk_ships
    boards.each do |board|
      board.check_sunk_ship
    end
  end

  def all_ships_sunk?
    if all_sunk_board = boards.find { |board| board.all_sunk? }
      game.game_over(other_board(all_sunk_board).owner)
      true
    else
      false
    end
  end

  def take_turns
    game.players.each do |player|
      @attack_coords[player] = player.choose_coordinates
    end
  end

  def other_board(not_board)
    boards.find {|b| b != not_board }
  end

  def draw_attacks
    boards.each do |board|
      player = board.owner
      coordinates = @attack_coords[board.owner]
      result = other_board(board).draw_attack(coordinates)
      puts_hit_miss(coordinates, player, result)
    end
  end
end
