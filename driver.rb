require_relative 'controller - board'
require_relative 'controller - game'
require_relative 'controller - user'
require_relative 'controller - ai'
require_relative 'view'

class CannotBeDrawn < StandardError
end

user_board = Board.new
ai_board = Board.new
game = Game.new(user_board, ai_board)
game.run
