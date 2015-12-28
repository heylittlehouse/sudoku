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
    !solved_board.flatten.include?("-")
  end

  def legal_board?
    legal_rows? && legal_cols? && legal boxes? ? true : false
  end

  def solve
    return false if !legal_board?
    return to_s(solved_board) if solved?


  end


private

  def find_all_possibilities
    all_possibilities = {}
    solved_board.each_with_index do |row, row_index|
      row.each_with_index do |col, col_index|
        coord = [row_index, col_index]
        all_possibilities[coord] = get_cell_possibilities(coord) if col == "-"
      end
    end
    puts all_possibilities
  end

  def get_cell_possibilities(coord)
    row = solved_board[coord[0]]
    col = column_board[coord[1]]
    #could be further narrowed down by checking box, but i'll leave that
    #for legal_board? method called by solve to check.
    impossibilities = (row + col).uniq
    %w[- 1 2 3 4 5 6 7 8 9].reject{|num| num if impossibilities.include?(num)}
  end

  def legal_rows?(check_board = @solved_board)
    check_board.map{|row| check(row)}.include?(false) ? false : true
  end

  def check(subsection)
    checker = subsection.uniq
    subsection == checker
  end

  def legal_cols?
    legal_rows?(column_board)
  end

  def legal_boxes?
    legal_rows?(three_by_three_board)
  end

  #the following methods arrange the board so that each nested array will represent
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

s = Sudoku.new("1-58-2----9--764-52--4--819-19--73-6762-83-9-----61-5---76---3-43--2-5-16--3-89--")
s.find_all_possibilities