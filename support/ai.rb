class AI
  attr_reader :already_guessed

  def initialize
    @already_guessed = []
    @coordinates = {}
  end

  def as_possessive
    "AI's"
  end

  def as_subject
    'AI'
  end

  def choose_coordinates
    @coordinates = {}
    col = rand(COL_RANGE)
    row = ROW_RANGE.to_a.sample
    @coordinates = {row: row, column: col}
    if already_guessed.include?(@coordinates)
      choose_coordinates
    else
      already_guessed << @coordinates
      @coordinates
    end
  end
end
