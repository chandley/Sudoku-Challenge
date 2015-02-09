require 'spec_helper'
require 'board'

describe Board do
  # let(:board)  { Board.new }
  let(:region) { double :region }

  it 'can contain a region' do
    board = Board.new.populate
    board.add(region)
    expect(board.regions).to include(region)
  end

  context 'size' do
    it 'has one box when size 1' do
      board = Board.new.populate
      expect(board.regions.select{ |region| region.type == :box }.count).to eq(1)
    end

    it 'has four boxes when size 2' do
      board = Board.new(2).populate
      expect(board.regions.select{ |region| region.type == :box }.count).to eq(4)
    end

    it 'knows which regions contain a given square' do
      board = Board.new
      square = double :square
      region = double :region, :squares => [square]
      board.add(region)
      expect(board.regions_containing(square)).to include region
    end
  end

  context 'game play' do
    it 'knows a 1*1 board starts with an unplayed square' do
      board = Board.new.populate
      expect(board.unplayed_squares.count).to eq(1)
    end

    it 'knows 4*4 board starts with 16 unplayed squares' do
      board = Board.new(2).populate
      expect(board.unplayed_squares.count).to eq(16)
    end

    it 'can play a square' do
      board = Board.new.populate
      square = square = board.squares.first
      board.play(square, 1)
      expect(board.unplayed_squares.count).to eq(0)
    end

    it 'can count played squares' do
      board = Board.new.populate
      square = square = board.squares.first
      board.play(square, 1)
      expect(board.played_squares.count).to eq(1)
    end

    it 'cant play a square twice' do
      board = Board.new.populate
      square = board.squares.first
      board.play(square, 1)
      expect { board.play(square, 1)} .to raise_error(RuntimeError)
    end

    it 'knows what order two squares were played in' do
      board = Board.new(2).populate
      square1 = board.squares.first
      square2 = board.squares.last
      board.play(square2, 1)
      board.play(square1, 2)
      expect(board.play_order(square2)<board.play_order(square1)).to be true
    end

    it 'can remove play for a square' do
      board = Board.new.populate
      square = board.squares.first
      board.play(square, 1)
      board.remove_play(square)
      expect(board.unplayed_squares.count).to eq(1)
    end

  end

  context 'legal moves' do
    it 'knows which moves are available for a square' do
      board = Board.new(2).populate
      square = board.squares.first
      expect(board.available_moves(square)).to eq([1,2,3,4])
    end

    it 'knows which square has the fewest legal moves' do
      board = Board.new(2).populate
      square = board.squares.first
      board.play(square, 1)
      expect(board.available_moves(board.square_least_moves)).to eq([2,3,4])
    end

    it 'knows can choose a square with fewest moves for empty board' do
      board = Board.new(2).populate
      expect(board.available_moves(board.square_least_moves)).to eq([1,2,3,4])
    end
  end

end
