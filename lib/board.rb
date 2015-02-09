%w(board region square board_viewer).each { |file| require_relative file + '.rb' }
class Board
  attr_accessor :squares
  attr_reader :regions, :size

  # TODO: refactor
  def initialize(size = 1)
    @regions = []
    @squares = []
    @size = size
  end

  def populate
    BoardMaker.new.populate_squares(self)
    BoardMaker.new.populate_regions(self)
    self
  end

  def add(region)
    @regions << region
  end

  def unplayed_squares
    boxes = @regions.select { |region| region.type == :box }
    boxes.map(&:squares).flatten.select { |square| !square.played? }
  end

  def played_squares
    squares - unplayed_squares
  end

  def regions_containing(square)
    @regions.select { |region| region.squares.include?(square) }
  end

  def available_moves(square)
    regions_containing(square).map { |region| region.possible_plays }.inject(:&)
  end

  def play(square, chosen_number)
    raise("Square already played") if square.played?
    squares.delete(square)
    squares.push(square)
    square.number = chosen_number
  end

   def remove_play(square)
    squares.delete(square)
    squares.unshift(square)
    square.remove_number
  end

  def play_order(square)
    squares.index(square)
  end

  def square_least_moves
    return squares.first if played_squares.count == 0
    unplayed_squares.sort{|x,y| available_moves(y) <=> available_moves(x)}.first
  end


end
