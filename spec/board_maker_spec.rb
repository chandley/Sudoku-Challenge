require 'board_maker'

describe BoardMaker do

  let(:maker) { BoardMaker.new }
  let(:board) { double :board, :size => 1, :squares => [:square] }
  let(:medium_board) { double :board, :size => 2, :squares => Array.new(16, :square) }

  it 'makes 4 rows for a size 2 board' do
    expect(maker.rows(medium_board).count).to eq 4
  end

  it 'makes 4 columns for a size 2 board' do
    expect(maker.columns(medium_board).count).to eq 4
  end

  it 'makes 4 boxes for a size 2 board' do
    expect(maker.boxes(medium_board).count).to eq 4
  end

  it 'makes 12 regions for a size 2 board' do
    expect(maker.regions(medium_board).count).to eq 12
  end

  it 'knows how to populate a size 1 board with 3 regions' do
    expect(board).to receive(:add).exactly(3).times
    maker.populate_regions(board)
  end

  it 'knows how to populate a size 2 board with 12 regions' do
    expect(medium_board).to receive(:add).exactly(12).times
    maker.populate_regions(medium_board)
  end

end