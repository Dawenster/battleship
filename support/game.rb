class Game
  attr_reader :interface, :ai, :user, :players, :boards
  attr_accessor :user_board, :ai_board

  def initialize(user_board, ai_board)
    @interface = Interface.new
    @ai = AI.new
    @user = User.new
    @players = [user, ai]
    @user_board = user_board
    @ai_board = ai_board
    @boards = [user_board, ai_board]
    @user_attack_coords = {}
    @ai_attack_coords = {}
  end

  def run
    user_board.place_all_the_ships
    ai_board.place_all_the_ships
    interface.display_boards(boards)
    until all_ships_sunk?
      take_turns
      draw_attacks
      interface.display_boards(boards)
      check_sunk_ships?
    end
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
      user.choose_coordinates(interface)
    else
      ai.choose_coordinates
    end
  end

  def draw_attacks
    boards.each do |board|
      if board == user_board
        boards.find {|b| b != board }.draw_attack(@user_attack_coords, interface, boards, board)
      else
        boards.find {|b| b != board }.draw_attack(@ai_attack_coords, interface, boards, board)
      end
    end
  end

  def check_sunk_ships?
    boards.each do |board|
      board.check_sunk_ship(interface, boards, board)
    end
  end

  def all_ships_sunk?
    boards.each do |board|
      if board.all_sunk?(board)
        interface.game_over(boards, board)
        exit
      end
    end
    false
  end
end
