class BoardViewer
  def get_rows(board)
    board.regions.select { |region| region.type == :row }
  end  

  def show_row(row)
    row.squares.map { |square| square.number ? square.number : 0 }
  end
  
  def show(board)
    get_rows(board).map { |row| show_row(row) }
  end
end
