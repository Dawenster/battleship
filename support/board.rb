COL_RANGE = 1..10
ROW_RANGE = "A".."J"
SHIPS = [1,2,3,4,5]
DIRECTIONS = [:row, :column]

class Board
  include BoardView
  attr_reader :playing_field, :ships_sunk

  def initialize
    set_blank_board
    @ships_sunk = []
  end

  def playing_field_values
    playing_field.values.flatten
  end

  def set_blank_board
    @playing_field = {}
    ROW_RANGE.to_a.each do |row_letter|
      @playing_field[row_letter] = Array.new(10) { "." }
      @playing_field[row_letter].unshift(row_letter)
    end
    @playing_field
  end

  def place_all_the_ships
    begin
      SHIPS.each do |ship_value|
        place_ship(ship_value)
      end
    rescue CannotBeDrawn
      set_blank_board
      place_all_the_ships
    end
  end

  def place_ship(ship_value)
    spot = random_starting_point
    ship_direction = DIRECTIONS.sample
    increment_direction = DIRECTIONS.find {|d| d != ship_direction}
    increment_value = spot[increment_direction]

    ship_value.times do
      coordinates = { 
        ship_direction => spot[ship_direction], 
        increment_direction => increment_value
      }
      draw(coordinates, ship_value)
      increment_value = increment_value.succ
    end
  end

  def draw(coordinates, value)
    row = coordinates[:row]
    column = coordinates[:column]
    row_values = playing_field[row] # sometimes this will be K, L, M... (if it goes off the map on a column boat)
    raise CannotBeDrawn unless row_values
    coordinate_value = row_values[column - 1]
    raise CannotBeDrawn unless coordinate_value == '.'
    playing_field[coordinates[:row]][coordinates[:column] - 1] = value
  end

  def draw_attack(coordinates, boards, board)
    if is_miss?(coordinates)
      playing_field[coordinates[:row]][coordinates[:column]] = 'O'
      miss(boards, board, coordinates)
    else
      playing_field[coordinates[:row]][coordinates[:column]] = 'X'
      hit(boards, board, coordinates)
    end
  end

  def is_miss?(coordinates)
    playing_field[coordinates[:row]][coordinates[:column]] == '.'
  end

  def random_starting_point
    col = rand(COL_RANGE)
    row = ROW_RANGE.to_a.sample
    {row: row, column: col}
  end

  def check_sunk_ship(boards, board)
    current_player = ''
    boards[0] == board ? current_player = 'Your' : current_player = "AI\'s"
    SHIPS.each do |ship|
      unless playing_field_values.include?(ship)
        ships_sunk << ship
        sunk_ship(ship, current_player) if ships_sunk.count(ship) == 1
      end
    end
  end

  def all_sunk?(board)
    board.ships_sunk.uniq.length == 5
  end
end


