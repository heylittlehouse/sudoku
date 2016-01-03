class Possibilities
  attr_reader :next_cell_string_index, :possibilities

  def initialize(board)
    @next_cell_string_index = get_next_cell_index(board)
    #I did this so that the program doesn't get tripped up
    #when it gets to the end of a board because it tries to
    #find the index of the non-existent character
    # *after* the last character
    @possibilities = next_cell_string_index ? get_possibilities_next_cell(board) : nil
  end

  def empty?
    possibilities == []
  end

  private

  def get_next_cell_index(board)
    board.board_string.index("-")
  end

  def get_possibilities_next_cell(board)
    coord = board.string_index_to_coord(next_cell_string_index)

    row = board.board[coord[0]]
    col = board.column_board[coord[1]]
    #could be further narrowed down by checking box, but this'll do.
    impossibilities = (row + col).uniq

    %w[1 2 3 4 5 6 7 8 9].reject{|num| num if impossibilities.include?(num)}
  end
end