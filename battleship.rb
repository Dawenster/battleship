require_relative 'support/view'
require_relative 'support/board'
require_relative 'support/game'
require_relative 'support/user'
require_relative 'support/ai'

class CannotBeDrawn < StandardError
end

user_board = Board.new
ai_board = Board.new
ai = AI.new
user = User.new
game = Game.new(user_board: user_board, ai_board: ai_board, ai: ai, user: user)
game.run
