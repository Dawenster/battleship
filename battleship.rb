require_relative 'support/board'
require_relative 'support/game'
require_relative 'support/user'
require_relative 'support/ai'
require_relative 'support/view'

class CannotBeDrawn < StandardError
end

user_board = Board.new
ai_board = Board.new
game = Game.new(user_board, ai_board)
game.run
