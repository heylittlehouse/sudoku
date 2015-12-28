require 'pry'

class Sudoku
  attr_reader :board
  attr_accessor :solved_board

  BOARD_WIDTH = 9
  SQUARE_WIDTH = 3

  def initialize(board_string)
    @board = board_string.split("").each_slice(9).to_a
    @solved_board = @board
    to_s(board)
  end

  def to_s(some_board)
    some_board.each do |line|
      puts line.join("")
    end
    puts "\n"
  end

  def solved?
    solved_board.flatten.include?("-")
  end

  def solve
    # return false if !legal_board?
    return to_s(solved_board) if solved?

  end

  private

#the following two methods arrange the board so that each nested array will represent
#What they are titled so I can easily access these later
  def column_board
    solved_board.transpose
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
        # binding.pry
      else
        start_row_index += SQUARE_WIDTH
        end_row_index += SQUARE_WIDTH
      end
    end

    square_board
  end

  def get_box(start_row_index, end_row_index)
    flattened_board = solved_board.flatten

    flattened_board[start_row_index..end_row_index] + flattened_board[start_row_index+BOARD_WIDTH..end_row_index+BOARD_WIDTH] + flattened_board[start_row_index+BOARD_WIDTH*2..end_row_index+BOARD_WIDTH*2]
  end

end
