class Possibilities
  attr_reader :possibilities

  def initialize(board)
    @possbilities = get_possibilities_next_cell(board)
  end

  def valid?
    !possibilities == []
  end

  private

  def get_possibilities_next_cell(board)
    string_index_of_next_cell = board.board_string.index("-")
    coord = board.string_index_to_coord(string_index_of_next_cell)

    row = board.board[coord[0]]
    col = board.column_board[coord[1]]
    #could be further narrowed down by checking box, but this'll do.
    impossibilities = (row + col).uniq

    %w[1 2 3 4 5 6 7 8 9].reject{|num| num if impossibilities.include?(num)}
  end
end