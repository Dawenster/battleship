class Game
  include GameView
  attr_reader :ai, :user, :user_board, :ai_board

  def initialize(options = {})
    @user_board, @ai_board = options[:user_board], options[:ai_board]
    @user, @ai = options[:user], options[:ai]
    @user_attack_coords = {}
    @ai_attack_coords = {}
  end

  def players
    [user, ai]
  end

  def boards
    [user_board, ai_board]
  end

  def take_turns
    players.each do |player|
      if player == user
        @user_attack_coords = attack(player)
      else
        @ai_attack_coords = attack(player)
      end
    end
  end

  def attack(player)
    if player == user
      user.choose_coordinates
    else
      ai.choose_coordinates
    end
  end

  def draw_attacks
    boards.each do |board|
      if board == user_board
        boards.find {|b| b != board }.draw_attack(@user_attack_coords, boards, board)
      else
        boards.find {|b| b != board }.draw_attack(@ai_attack_coords, boards, board)
      end
    end
  end

  def check_sunk_ships?
    boards.each do |board|
      board.check_sunk_ship(boards, board)
    end
  end

  def all_ships_sunk?
    boards.each do |board|
      if board.all_sunk?(board)
        game_over(boards, board)
        exit
      end
    end
    false
  end
end
