['board','region','square','board_viewer'].each {|file| require_relative file + '.rb'}
class Board

  attr_accessor :squares
  attr_reader :regions, :size
  #TODO refactor
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
    boxes = @regions.select {|region| region.type == :box}
    boxes.map {|region| region.squares}.flatten.select{|square| !square.played?}
  end


  def regions_containing(square)
    @regions.select {|region| region.squares.include?(square)}
  end

  def available_moves(square)
     regions_containing(square).map{ |region| region.possible_plays }.inject(:&)
  end



end
