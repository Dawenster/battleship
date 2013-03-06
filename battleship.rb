require_relative 'support/view'
require_relative 'support/board'
require_relative 'support/game'
require_relative 'support/user'
require_relative 'support/ai'
require_relative 'support/turns_controller'

class CannotBeDrawn < StandardError
end

TurnsController.new.run
