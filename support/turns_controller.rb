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
    @user_attack_coords = {}
    @ai_attack_coords = {}
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
      if player.user?
        @user_attack_coords = player.choose_coordinates
      else
        @ai_attack_coords = player.choose_coordinates
      end
    end
  end

  def draw_attacks
    game.boards.each do |board|
      if board.owner.user?
        game.boards.find {|b| b != board }.draw_attack(@user_attack_coords, user)
      else
        game.boards.find {|b| b != board }.draw_attack(@ai_attack_coords, ai)
      end
    end
  end
end
