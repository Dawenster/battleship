class Game
  include GameView
  attr_reader :ai, :user, :user_board, :ai_board

  def initialize(options = {})
    @user_board, @ai_board = options[:user_board], options[:ai_board]
    @user, @ai = options[:user], options[:ai]
    set_boards
  end

  def set_boards
    user_board.place_all_the_ships
    ai_board.place_all_the_ships
  end

  def players
    [user, ai]
  end

  def boards
    [user_board, ai_board]
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
