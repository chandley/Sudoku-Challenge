%w(board region square board_viewer board_maker).each.each {|file| require_relative file + '.rb'}

class Game

  def initialize(size=1)
    @board = Board.new(size).populate
  end

  def board
    @board
  end

  def show_board
    viewer = BoardViewer.new
    viewer.show(@board)
  end

  def make_a_move
    raise 'game finished' if finished?
    chosen_square = board.square_least_moves
    available_moves = board.available_moves(chosen_square)
    # if available_moves.count == 0
    #   board.played_squares.count
    #   go_back = (1 + (board.played_squares.count*(rand ** 4)).to_i)
    #   puts go_back
    #   go_back.times { unmake_last_move }
    #   go_back.times { make_a_move }
    #   make_a_move

    # else
      chosen_square.number = available_moves.sample
    # end
  end

  def finished?
    board.unplayed_squares.count == 0
  end

  def unmake_last_move
    last_played_square = @board.squares[-1]
    @board.remove_play(last_played_square)
  end

end
