require 'pry'

class Sudoku
  attr_reader :board

  initialize(board_string)
    @board = board_string.splice(9)
  end
end