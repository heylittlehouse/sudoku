class Board
  attr_reader :board, :board_string

  BOARD_WIDTH = 9
  SQUARE_WIDTH = 3

  def initialize(board_string)
    @board_string = board_string
    @board = board_string.split("").each_slice(9).to_a
  end

  def solved?
    !board_string.include?("-")
  end

  def legal_board?
    #makes sure there are no duplicates in each row/col/box
    legal_rows? && legal_cols? && legal_boxes? ? true : false
  end

  def column_board
    board.transpose
  end

  private

  def legal_rows?(check_board = @board)
    check_board.map{|row| check(row)}.include?(false) ? false : true
  end

  def check(subsection)
    nums_in_sub = subsection.reject{|char| char == '-'}
    checker = nums_in_sub.uniq
    nums_in_sub == checker
  end

  def legal_cols?
    legal_rows?(column_board)
  end

  def legal_boxes?
    legal_rows?(three_by_three_board)
  end

  def three_by_three_board
    square_board = []
    start_row_index = 0
    end_row_index = SQUARE_WIDTH - 1

    while square_board.length < BOARD_WIDTH
      box = get_box(start_row_index, end_row_index)
      square_board << box

      #will jump the index of the flattened board to the next row of squares
      #if you've reached the end of a row of squares

      if square_board.length % 3 == 0
        start_row_index += SQUARE_WIDTH + BOARD_WIDTH * 2
        end_row_index += SQUARE_WIDTH + BOARD_WIDTH * 2
      else
        start_row_index += SQUARE_WIDTH
        end_row_index += SQUARE_WIDTH
      end
    end

    square_board
  end

  def get_box(start_row_index, end_row_index)
    flattened_board = board.flatten

    flattened_board[start_row_index..end_row_index] + flattened_board[start_row_index+BOARD_WIDTH..end_row_index+BOARD_WIDTH] + flattened_board[start_row_index+BOARD_WIDTH*2..end_row_index+BOARD_WIDTH*2]
  end
end